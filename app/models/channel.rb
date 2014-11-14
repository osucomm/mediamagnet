class Channel < ActiveRecord::Base
  include Taggable

  # STI types
  TYPES = [TwitterChannel,InstagramChannel,WebChannel,EventChannel,FacebookChannel,YoutubeChannel]

  # Associations
  belongs_to :entity
  has_one :contact, as: :contactable, dependent: :destroy
  has_many :items
  has_many :mappings, as: :mappable

  # Validations
  validates :name, presence: true
  validates :service_identifier, presence: true

  accepts_nested_attributes_for :contact

  #
  delegate :users, to: :entity

  # Callbacks
  after_create :refresh_items

  # Scopes
  scope :needs_refresh, -> {
    where('last_polled_at < ?', 1.hour.ago)
  }

  class << self
    def type_name
      self.name.sub('Channel', '')
    end

    def policy_class
      ChannelPolicy
    end
  end

  def type_name
    self.class.type_name
  end

  def service_id_name
    'Service Identifier'
  end

  def display_contact
    contact || entity.contact
  end

  def item_count
    items.count
  end

  def refresh_items
    logger.info {"Channel #{name} refreshed."}
    update_attribute(:last_polled_at, Time.now)
  end
  handle_asynchronously :refresh_items

end
