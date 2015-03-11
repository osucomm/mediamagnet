class Item < ActiveRecord::Base
  include ApprovedEntityScope
  include ElasticsearchSearchable
  Kaminari::Hooks.init
  Elasticsearch::Model::Response::Response.__send__ :include, Elasticsearch::Model::Response::Pagination::Kaminari

  #index_name    "items-#{Rails.env}"

  has_many :events, dependent: :destroy
  has_many :assets, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :custom_tags, source: :tag, through: :taggings

  has_many :keywordings, as: :keywordable, dependent: :destroy
  has_many :keywords, -> { uniq }, through: :keywordings

  has_and_belongs_to_many :links

  belongs_to :channel
  has_one :entity, through: :channel
  has_one :link #, class_name: 'Link', foreign_key: 'item_id'

  Category.all.each do |category|
    association_name = "#{category.name}_keywords".to_sym

    has_many association_name,
      -> { where(category_id: category.id).uniq },
      through: :keywordings,
      source: :keyword

    define_method "#{category.name.pluralize}" do |*args|
      send(association_name).map(&:name)
    end
  end

  # Elasticsearch
  index_name  'items'
  settings index: { number_of_shards: 1 } do
    mappings dynamic: 'false' do
      indexes :audiences, analyzer: 'keyword', type: 'string'
      indexes :formats, analyzer: 'keyword', type: 'string'
      indexes :colleges, analyzer: 'keyword', type: 'string'
      indexes :locations, analyzer: 'keyword', type: 'string'
      indexes :channel_type, analyzer: 'keyword', type: 'string'
      indexes :tags, analyzer: 'keyword', type: 'string'
      indexes :title, type: 'string'
      indexes :description, type: 'string'
      indexes :content, type: 'string'
      indexes :channel_id, type: 'integer'
      indexes :entity_id, type: 'integer'
      indexes :published_at, type: 'date'
      indexes :url, analyzer: 'keyword', type: 'string'
    end
  end

  validates :guid, presence: :true
  validates :channel_id, presence: :true

  before_save :links_from_text_fields
  before_save :sanitize_plain_elements
  after_create() { __elasticsearch__.index_document if entity.approved? }
  #Partial updates are unaware of changes in has_many through relationships, so
  #avoid update_document on save.
  after_save() { __elasticsearch__.delete_document; __elasticsearch__.index_document if entity.approved? }
  after_destroy() { __elasticsearch__.delete_document if entity.approved? }

  delegate :mappings, to: :channel
  delegate :name, :id, to: :channel, prefix: :channel
  delegate :entity_id, to: :channel

  scope :recent, -> { order('published_at DESC') }
  scope :most_recent, -> { recent.limit(1) }
  scope :with_channel, -> { includes(:channel).where.not(channels: { id: nil }) }
  scope :with_all_keywords, -> { includes(:keywords) }
  scope :by_channels, -> channel_ids { where(channel_id: channel_ids) }
  scope :by_tags, -> tag_ids { joins(:taggings).where('taggings.tag_id' => tag_ids) }
  scope :by_entities, -> entity_ids { includes(:channel).where(channels: { entity_id: entity_ids }) }
  scope :by_keywords, -> keyword_ids { joins(:keywordings).where('keywordings.keyword_id' => keyword_ids) }
  scope :between, -> (starts_at, ends_at) { after(starts_at).before(ends_at) }
  scope :before, -> (datetime) { where('published_at < ?', datetime) }
  scope :after, -> (datetime) { where('published_at > ?', datetime) }
  scope :eager, -> { eager_load(:assets, :link, :links, :custom_tags, :channel, :keywords, :taggings) }

  class << self
    # define search method to be used in Rails controller
    def search(query=nil, options={})

      # setup empty search definition
      @search_definition = {
        query: {},
        filter: {},
        facets: {},
        #fields: [:id],
      }

      # Prefill and set the filters (top-level `filter` and `facet_filter` elements)
      __set_filters = lambda do |key, f|

        @search_definition[:filter][:and] ||= []
        @search_definition[:filter][:and]  |= [f]

        @search_definition[:facets].keys.each do |filter_name| 
          unless key.to_sym == filter_name
            @search_definition[:facets][filter_name][:facet_filter][:and] ||= []
            @search_definition[:facets][filter_name][:facet_filter][:and] |= [f]
          end
        end
      end

      # facets
      @search_definition[:facets] = search_facet_fields.each_with_object({}) do |a,hsh|
        hsh[a.to_sym] = {
          terms: {
            field: a
          },
          facet_filter: {}
        }
      end

      # query
      unless query.blank?
        @search_definition[:query] = {
          bool: {
            should: [
              { multi_match: {
                query: query,
                # limit which fields to search, or boost here:
                fields: search_text_fields,
                operator: 'or'
              }
              },
              { multi_match: {
                query: Time.now,
                # limit which fields to search, or boost here:
                fields: :published_at
              }
              }
            ]
          }
        }
      else
        @search_definition[:query] = { 
          function_score: {
            functions: [
              { gauss: { published_at: { scale: '1w', decay: '0.5' } } }
            ]
          }
        }
      end

      # add filters for facets
      options.each do |key,value|
        next unless search_facet_fields.include?(key)

        if value.class == Array
          f = { terms: { key.to_sym => value }  }
        else
          f = { term: { key.to_sym => value } }
        end

        __set_filters.(key, f)

      end

      # execute Elasticsearch search
      __elasticsearch__.search(@search_definition)

    end
  end

  def channel_type
    channel.type_name.downcase
  end

  def url
    link.present? ? link.url : "https://mediamagnet.osu.edu/items/#{id}"
  end

  class << self 
    def keywords
      all.map(&:keywords).flatten.uniq
    end

    def tagged_with(search_tags, op = :or)
      keywords = []
      tags = []
      op = :and unless op == :or

      search_tags.each do |search_tag|
        search_tag.downcase!
        if k = Keyword.find_by_name(search_tag)
          keywords << k
        else
          if t = Tag.find_by_name(search_tag)
            tags << t
          end
        end
      end

      Item.eager_load(:taggings, :keywordings).where(
        Tagging.arel_table[:tag_id].in(tags)
        .send( op, Keywording.arel_table[:keyword_id].in(keywords) )
      )
    end

    def import
      from_approved.each do |item|
        item.__elasticsearch__.index_document
      end
    end

    private

    def search_facet_fields
      ['entity_id', 'channel_id', 'tags', 'channel_type'].concat(Category.all.map{|c| c.name.pluralize})
    end

    def search_text_fields
      ['title', 'description', 'content']
    end

  end

  def to_s
    [:description, :title, :guid].each do |field|
      return self.send(field) unless self.send(field).blank?
    end
  end

  def tag_names=(new_tags)
    new_tags = [] if new_tags.nil?
    new_tags.map!(&:downcase)
    existing_tags = custom_tags.map(&:name)

    (new_tags - existing_tags).each do |tag_text|
      taggings.build(tag_text: tag_text)
    end

    save!

    taggings.joins(:tag).where("tags.name IN (?)", (existing_tags - new_tags)).destroy_all

    reload
    return (new_tags - existing_tags)
  end

  def tags
    (custom_tags.map(&:name) + keywords.map(&:name)).uniq
  end

  def remove_keyword(keyword)
    item_keywordings = keywordings.where(keyword_id: keyword.id)
    item_keywordings.first.destroy if item_keywordings.first
  end

  def distinct_keywords
    keywords.map(&:id).uniq
  end

  def as_indexed_json(options={})
    self.as_json(only:
                 %w(id title channel_id content description guid published_at),
                 include: { keywords: { only: [ :id, :name, :category_name ] },
                            links: { only: [:url] } },
                 methods: [:channel_type, :tags, :entity_id, :url].concat(Category.all.map{|c| c.name.pluralize.to_sym}))
  end


  private

  # Build list of associated links from all of our text fields.
  def links_from_text_fields
    all_text.scan(Link::PATTERN).each do |url| 
      dest_url = Link.resolve_uri(url)
      if dest_url
        new_link = Link.where(url: dest_url).first_or_create
        links << new_link unless links.include?(new_link)
      end
    end
  end

  def sanitize_plain_elements
    self.title = Sanitize.fragment(title)
    self.description = Sanitize.fragment(description)
  end


  def all_text
    %w(title description content).map do |field|
      send(field).to_s
    end.join(' ')
  end

  def mapped_keywords
    channel.all_mappings.where(:tag_id => custom_tags.map(&:id)).keywords
  end

end
