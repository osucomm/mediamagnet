class Item < ActiveRecord::Base
  include Taggable
  has_many :channel_inherited_keywords, source: :keywords, through: :channel
  has_many :entity_inherited_keywords, source: :keywords, through: :entity

  belongs_to :channel
  has_one :entity, through: :channel
  has_many :assets, dependent: :destroy

  validates :guid, presence: :true
  validates :channel_id, presence: :true

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
  end

  def to_s
    [:title, :description, :guid].each do |field|
      return self.send(field) unless self.send(field).blank?
    end
  end

  def all_keywords
    keywords + channel_inherited_keywords + entity_inherited_keywords
  end

  def link
    if attributes['link'].blank?
      channel.link_for(self)
    else
      attributes['link']
    end
  end

end
