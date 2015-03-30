class Entity < ActiveRecord::Base
  # Associations
  has_one :contact, as: :contactable, dependent: :destroy
  has_many :channels, dependent: :destroy
  has_many :items, through: :channels
  has_many :mappings, as: :mappable, dependent: :destroy
  has_many :mapped_tags, through: :mappings, source: :tag
  has_many :mapped_keywords, through: :mappings, source: :keyword
  has_and_belongs_to_many :users

  has_many :keywordings, as: :keywordable, dependent: :destroy
  has_many :keywords, through: :keywordings

  belongs_to :parent, class_name: "Entity"
  has_many :children, class_name: "Entity", foreign_key: "parent_id"

  # Validations
  validates :name, presence: true, uniqueness: true

  alias_method :all_keywords, :keywords

  # Scopes
  default_scope -> {
    order('name ASC')
  }

  scope :without_channels, -> { where('entities.id not in (select entity_id from channels)') }
  scope :approved, -> { where(approved: true) }
  scope :not_approved, -> { where(approved: false) }

  #Callbacks
  before_save :update_elasticsearch_on_approved_change

  accepts_nested_attributes_for :contact

  alias_method :all_mappings, :mappings

  class << self
    def help_text
      <<-EOT
        An entity is an umbrella for similar content channels and usually
        represents a unit or organization within the university.
      EOT
    end
  end

  def to_s
    name
  end

  def has_user? user
    users.exists? user.id
  end

  def channels_mappings
    channels.map(&:channel_mappings)
  end

  def add_keyword(keyword)
    keywords << keyword
    items.each do |item|
      item.keywords << keyword
    end
  end

  def remove_keyword(keyword)
    keywordings.where(keyword_id: keyword.id).destroy_all
    items.each do |item|
      item.remove_keyword(keyword)
    end
  end

  def item_count
    items.count
  end

  def approved?
    approved
  end

  def update_elasticsearch_on_approved_change
    if approved_changed?
      if approved?
        items.each {|item| item.__elasticsearch__.index_document}
      else
        items.each {|item| item.__elasticsearch__.delete_document}
      end
    end
  end

end
