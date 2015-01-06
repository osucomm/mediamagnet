class Channel < ActiveRecord::Base
  include Taggable

  has_one :token

  # STI types
  TYPES = [TwitterChannel,InstagramChannel,WebChannel,EventChannel,FacebookPageChannel,YoutubePlaylistChannel]

  # Associations
  belongs_to :entity
  has_one :contact, as: :contactable, dependent: :destroy
  has_many :items, dependent: :destroy
  has_many :mappings, as: :mappable, dependent: :destroy

  # Validations
  validates :name, presence: true
  validates :service_identifier, presence: true
  validate :service_identifier_validator

  accepts_nested_attributes_for :contact

  #
  delegate :users, to: :entity
  delegate :has_user?, to: :entity
  delegate :entity_mappings, to: :entity

  # Callbacks
  after_initialize :set_keywords
  after_initialize :get_info

  # Scopes
  scope :needs_refresh, -> {
    where('last_polled_at < ?', 1.hour.ago)
  }

  class << self
    def type_name
      self.name.sub('Channel', '').titleize
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

  def all_mappings
    mappings = Mapping.arel_table
    Mapping.where(
      ((mappings[:mappable_type].eq('Channel').and(mappings[:mappable_id].eq(id)))
      .or(mappings[:mappable_type].eq('Entity').and(mappings[:mappable_id].eq(entity.id))))
    ).order(:type)
  end

  def all_mappings_distinct
    all_mappings
  end


      #.group(mappings[:mappable_type]).project('id,min(type)')

    #p = Mapping.where("(mappable_type == 'Channel' AND mappable_id == ?) OR
    #               (mappable_type == 'Entity' AND mappable_id == ?)", id, entity.id)
    #p.group(:keyword_id, :tag_id).order(:mappable_type)
    #mappings.where(
    #   ((mappings[:mappable_type]).eq('Entity')).and AND entity_mappings.map(&:id) 
    #out = []
    #entity_mappings.select do |mapping|
    #  out << mapping unless out.map(&:tag).include?(mapping.tag)
    #end
    #mappings.select do |mapping|
    #  out << mapping unless out.map(&:tag).include?(mapping.tag)
    #end
    #out.sort_by! do |a|
    #  a.keyword.name
    #end

  def refresh_items
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

  def log_refresh
    logger.info {"Channel #{name} refreshed at #{Time.now}."}
    update_attribute(:last_polled_at, Time.now)
  end

  def service_identifier_is_valid?
    service_identifier.present? && !service_account.nil?
  end

  private

  def service_identifier_validator
    unless service_identifier_is_valid?
      errors.add :service_identifier, " must be a valid #{service_id_name.downcase}"
    end
  end

  def get_info
  end

  def initial_keywords
    []
  end

  def set_keywords
    initial_keywords.each do |keyword_text|
      keyword = Keyword.where(name: keyword_text, 
                              display_name: keyword_text).first_or_create
      keywords << keyword unless keywords.include?(keyword)
    end
  end

end
