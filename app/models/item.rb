class Item < ActiveRecord::Base
  include ApprovedEntityScope
  include ElasticsearchSearchable

  has_many :events, dependent: :destroy
  has_many :assets, dependent: :destroy
  has_many :taggings, dependent: :destroy
  has_many :tags, through: :taggings

  has_many :keywordings, as: :keywordable, dependent: :destroy
  has_many :keywords, -> { uniq }, through: :keywordings

  has_and_belongs_to_many :links

  belongs_to :channel
  has_one :entity, through: :channel
  has_one :link, class_name: 'Link', foreign_key: 'item_id'

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

  validates :guid, presence: :true
  validates :title, presence: :true
  validates :description, presence: :true
  validates :channel_id, presence: :true

  before_save :links_from_text_fields

  delegate :mappings, to: :channel
  delegate :type_name, to: :channel
  delegate :name, :id, to: :channel, prefix: :channel
  delegate :entity_id, to: :channel
  delegate :url, to: :link

  default_scope -> {
    order('published_at DESC')
  }

  scope :most_recent, -> { order('published_at DESC').limit(1) }
  scope :with_channel, -> { includes(:channel).where.not(channels: { id: nil }) }
  scope :with_all_keywords, -> { includes(:keywords) }
  scope :by_channels, -> channel_ids { where(channel_id: channel_ids) }
  scope :by_tags, -> tag_ids { joins(:taggings).where('taggings.tag_id' => tag_ids) }
  scope :by_entities, -> entity_ids { includes(:channel).where(channels: { entity_id: entity_ids }) }
  scope :by_keywords, -> keyword_ids { joins(:keywordings).where('keywordings.keyword_id' => keyword_ids) }
  scope :between, -> (starts_at, ends_at) { after(starts_at).before(ends_at) }
  scope :before, -> (datetime) { where('published_at < ?', datetime) }
  scope :after, -> (datetime) { where('published_at > ?', datetime) }


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

    private

    def search_facet_fields
      ['entity_id', 'channel_id', 'tag_names', 'courses']
    end

    def search_text_fields
      ['title', 'description', 'content']
    end

  end

  def to_s
    [:title, :description, :guid].each do |field|
      return self.send(field) unless self.send(field).blank?
    end
  end

  def tag_names=(new_tags)
    new_tags = [] if new_tags.nil?
    new_tags.map!(&:downcase)
    existing_tags = tags.map(&:name)

    (new_tags - existing_tags).each do |tag_text|
      taggings.build(tag_text: tag_text)
    end

    save!

    taggings.joins(:tag).where("tags.name IN (?)", (existing_tags - new_tags)).destroy_all

    reload
    return (new_tags - existing_tags)
  end

  def tag_names
    tags.map(&:name) + keywords.map(&:name)
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
                            links: { only: [:url] },
                            events: {}  },
                 methods: [:tag_names, :entity_id, :url].concat(category_names))
  end

  private

  def category_names
    Category.all.map{|cat| "#{cat.name.pluralize}"}
  end

  # Build list of associated links from all of our text fields.
  def links_from_text_fields
    all_text.scan(Link::PATTERN).each do |url| 
      dest_url = Link.resolve_uri(url)
      new_link = Link.where(url: dest_url).first_or_create
      links << new_link unless links.include?(new_link)
    end
  end

  def all_text
    %w(title description content).map do |field|
      send(field).to_s
    end.join(' ')
  end

  def mapped_keywords
    channel.all_mappings.where(:tag_id => tags.map(&:id)).keywords
  end

end
