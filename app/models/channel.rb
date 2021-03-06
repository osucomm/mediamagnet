class Channel < ActiveRecord::Base
  include ApprovedEntityScope

  has_one :token, dependent: :destroy

  # STI types
  TYPES = [TwitterChannel,InstagramChannel,RssChannel,FacebookPageChannel,YoutubePlaylistChannel,IcalendarChannel,FundChannel,JsonChannel]

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
  validates :service_identifier, presence: true,
    uniqueness: { scope: :type, message: "has already been registered" }
  validate :service_identifier_validator

  accepts_nested_attributes_for :contact

  #
  delegate :users, :has_user?, :entity_mappings, :approved, to: :entity

  # Callbacks
  after_initialize :get_info, if: 'new_record?'
  after_create :set_keywords
  after_create :refresh if Rails.env == 'production'
  before_destroy :destroy_all_items

  # Scopes

  scope :by_type, -> type { where(:type => type) }
  scope :refresh_order, -> { order('last_polled_at asc') }

  class << self
    def stale_for_days(number_of_days)
      ids = all.to_a.keep_if do |channel|
        channel.items.any? &&
        channel.items.most_recent.first.published_at.present? &&
        channel.items.most_recent.first.published_at < number_of_days.days.ago
      end.map(&:id)
      where(id: ids)
    end
    def needs_refresh
      ids = all.to_a.keep_if do |channel|
        (channel.last_polled_at.nil? || 
        channel.last_polled_at < channel.max_refresh_interval.seconds.ago) &&
        !channel.disabled && 
        !channel.locked?
      end.map(&:id)
      where(id: ids).refresh_order
    end

    def type_name
      self.name.sub('Channel', '').titleize
    end

    def machine_type_name
      self.name.sub('Channel', '').titleize.parameterize
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
    def unicode_icon
      'f09e'
    end

    def public_types
      TYPES - [FundChannel]
    end
  end

  def to_s
    name
  end

  def icon
    self.class.icon
  end
  def unicode_icon
    self.class.unicode_icon
  end

  def all_mappings
    mappings = Mapping.arel_table
    Mapping.where(
      ((mappings[:mappable_type].eq('Channel').and(mappings[:mappable_id].eq(id)))
      .or(mappings[:mappable_type].eq('Entity').and(mappings[:mappable_id].eq(entity.id))))
    ).order(:type)
  end

  def refresh
    unless locked?
      job = RefreshChannelJob.perform_later self
      update(job_id: job.provider_job_id)
    end
  end

  def all_keywords
    Keyword.where(id: (entity.keywords + keywords).map(&:id))
  end

  def all_mappings_distinct
    all_mappings
  end

  def type_name
    self.class.type_name
  end

  def machine_type_name
    self.class.machine_type_name
  end

  def locked?
    Sidekiq::Queue.new.find_job(job_id).present?
  end

  def service_id_name
    'Service Identifier'
  end

  def url
    service_url
  end

  def service_url
    read_attribute(:url)
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

  def transfer_to(new_entity)
    entity.keywords.each do |keyword|
      remove_keyword_from_items(keyword)
    end
    entity.mappings.each do |mapping|
      mapping.remove_keyword_from_items
    end
    self.entity = new_entity
    self.save
    self.reload
    new_entity.keywords.each do |keyword|
      add_keyword(keyword)
    end
    new_entity.mappings.each do |mapping|
      mapping.add_keyword_to_items
    end
  end

  def add_keyword(keyword)
    keywords << keyword
    add_keyword_to_items(keyword)
  end

  def remove_keyword(keyword)
    keywordings.where(keyword_id: keyword.id).first.destroy
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
      keyword = Keyword.where(name: keyword_text).first_or_create
      keywords << keyword unless keywords.include?(keyword)
    end
  end

  def add_keyword_to_items(keyword)
    items.each {|item| item.keywords << keyword }
  end

  def remove_keyword_from_items(keyword)
    items.each {|item| item.remove_keyword(keyword)}
  end


end
