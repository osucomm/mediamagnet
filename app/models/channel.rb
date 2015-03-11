class Channel < ActiveRecord::Base
  include ApprovedEntityScope

  has_one :token, dependent: :destroy

  validates :service_identifier,
    uniqueness: { scope: :type, message: "has already been registered" }

  # STI types
  TYPES = [TwitterChannel,InstagramChannel,RssChannel,EventRssChannel,FacebookPageChannel,YoutubePlaylistChannel,IcalendarChannel]

  # Associations
  belongs_to :entity
  has_one :contact, as: :contactable, dependent: :destroy
  has_many :items
  has_many :mappings, as: :mappable, dependent: :destroy
  has_many :mapped_tags, through: :mappings, source: :tag
  has_many :mapped_keywords, through: :mappings, source: :keyword
  has_many :keywordings, as: :keywordable, dependent: :destroy
  has_many :keywords, through: :keywordings, before_remove: :remove_keyword_from_items

  # Validations
  validates :name, presence: true
  validates :service_identifier, presence: true
  validate :service_identifier_validator

  accepts_nested_attributes_for :contact

  #
  delegate :users, :has_user?, :entity_mappings, :approved, to: :entity

  # Callbacks
  after_initialize :set_keywords
  after_initialize :get_info
  after_create :refresh_items if Rails.env == 'production'
  before_destroy :destroy_all_items

  # Scopes
  scope :needs_refresh, -> {
    where('last_polled_at < ? OR last_polled_at is null', 1.hour.ago)
  }

  scope :by_type, -> type { where(:type => type) }

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

  def to_s
    name
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

  def all_keywords
    entity.keywords + keywords
  end

  def all_mappings_distinct
    all_mappings
  end

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

  def approved?
    entity.approved
  end

  def log_refresh
    logger.info {"Channel #{name} refreshed at #{Time.now}."}
    update_attribute(:last_polled_at, Time.now)
  end

  def add_keyword(keyword)
    keywords << keyword
    items.each do |item|
      item.keywords << keyword
    end
  end

  def remove_keyword(keyword)
    keywordings.where(keyword_id: keyword.id).destroy_all
    remove_keyword_from_items(keyword)
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

  def destroy_all_items
    items.each do |i|
      i.destroy
    end
  end

  def set_keywords
    initial_keywords.each do |keyword_text|
      keyword = Keyword.where(name: keyword_text, 
                              display_name: keyword_text).first_or_create
      keywords << keyword unless keywords.include?(keyword)
    end
  end

  def remove_keyword_from_items(keyword)
    items.each {|item| item.remove_keyword(keyword)}
  end

end
