class Channel < ActiveRecord::Base
  include Taggable

  has_one :token

  # STI types
  TYPES = [TwitterChannel,InstagramChannel,WebChannel,EventChannel,FacebookPageChannel,YoutubePlaylistChannel]

  # Associations
  belongs_to :entity
  has_one :contact, as: :contactable, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :channel_mappings, as: :mappable, dependent: :destroy

  # Validations
  validates :name, presence: true
  validates :service_identifier, presence: true

  accepts_nested_attributes_for :contact

  #
  delegate :users, to: :entity
  delegate :has_user?, to: :entity
  delegate :entity_mappings, to: :entity

  # Callbacks
  after_initialize :set_keywords
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

    def help_text
      <<-EOT
        Each channel represents a way of getting content to Media Magnet. Simply
        tell us how to find your content, and we'll take care of the rest.
      EOT
    end

    def icon
      'rss'
    end
  end

  def icon
    self.class.icon
  end

  def mappings
    out = []
    entity_mappings.select do |mapping|
      out << mapping unless out.map(&:tag).include?(mapping.tag)
    end
    out.sort_by! do |a|
      a.tag.name
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

  private

  def set_keywords
  end

end
