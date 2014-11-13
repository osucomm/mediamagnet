class Item < ActiveRecord::Base
  include Taggable

  belongs_to :channel
  has_one :entity, through: :channel
  has_many :assets

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
  scope :by_channel, -> channel_id { where(:channel_id => channel_id) }

  def to_s
    [:title, :description, :guid].each do |field|
      return self.send(field) unless self.send(field).blank?
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
