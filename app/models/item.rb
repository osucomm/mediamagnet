class Item < ActiveRecord::Base
  belongs_to :channel
  has_one :entity, through: :channel
  has_many :assets
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings
  has_many :keywords, through: :taggings

  validates :guid, presence: :true
  validates :channel_id, presence: :true

  delegate :mappings, to: :channel

  default_scope -> {
    order('published_at DESC')
  }

  scope :most_recent, -> { order('published_at DESC').limit(1) }
  scope :with_channel, -> { includes(:channel).where.not(channels: { id: nil }) }

  def to_s
    [:title, :description, :guid].each do |field|
      return self.send(field) unless self.send(field).blank?
    end
  end

  def tags=(tags)
    tags.each do |tag_text|
      taggings.build(tag_text: tag_text)
    end
  end

  def link
    if attributes['link'].blank?
      channel.link_for(self)
    else
      attributes['link']
    end

  end

end
