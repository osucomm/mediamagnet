class Item < ActiveRecord::Base
  include Taggable
  has_many :channel_inherited_keywords, source: :keywords, through: :channel
  has_many :entity_inherited_keywords, source: :keywords, through: :entity
  has_many :events
  has_many :item_links
  has_many :links, through: :item_links
  has_many :assets, dependent: :destroy

  belongs_to :channel
  has_one :entity, through: :channel
  has_one :link, class_name: 'Link', foreign_key: 'item_id'

  validates :guid, presence: :true
  validates :channel_id, presence: :true

  before_save :links_from_text_fields

  delegate :mappings, to: :channel
  delegate :type_name, to: :channel
  delegate :name, :id, to: :channel, prefix: :channel

  default_scope -> {
    order('published_at DESC')
  }

  scope :most_recent, -> { order('published_at DESC').limit(1) }
  scope :with_channel, -> { includes(:channel).where.not(channels: { id: nil }) }
  scope :with_all_keywords, -> { includes(:keywords, :channel_inherited_keywords, :entity_inherited_keywords) }
  scope :by_channels, -> channel_ids { where(channel_id: channel_ids) }

  class << self 
    def by_keywords(keyword_ids)
      # Item ids
      items = Tagging.on_items.by_keywords(keyword_ids).map(&:taggable)
      channel_entity_items = Tagging.not_on_items.by_keywords(keyword_ids).map(&:taggable).map(&:items)

      (items + channel_entity_items).first || Item.none
    end

    def all_keywords
      with_all_keywords.map(&:all_keywords).flatten.uniq
    end
  end

  def to_s
    [:title, :description, :guid].each do |field|
      return self.send(field) unless self.send(field).blank?
    end
  end

  def all_keywords
    keywords + channel_inherited_keywords + entity_inherited_keywords
  end

  private

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

end
