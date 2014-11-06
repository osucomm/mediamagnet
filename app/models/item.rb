class Item < ActiveRecord::Base
  belongs_to :channel
  has_one :entity, through: :channel
  has_many :assets
  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings
  has_many :keywords, through: :taggings

  validates :guid, presence: :true
  validates :channel_id, presence: :true

  default_scope -> {
    order('published_at DESC')
  }

  scope :most_recent, -> {
    order('published_at DESC').limit(1)
  }

  def to_s
    [:title, :description, :guid].each do |field|
      return self.send(field) unless self.send(field).blank?
    end
  end

  def tags=(tags)
    tags.each do |tag_text|
      tag = Tag.where(name: tag_text.downcase).first_or_create
      # TODO: Go Look for mapping of tag to keyword, get keyword.
      taggings.build(tag_id: tag.id, keyword_id: nil)
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
