class Entity < ActiveRecord::Base
  # Associations
  has_one :contact, as: :contactable, dependent: :destroy
  has_one :manifest, dependent: :destroy
  has_many :channels, dependent: :destroy
  has_many :items, through: :channels
  has_many :mappings, as: :mappable, dependent: :destroy
  has_and_belongs_to_many :users

  has_many :keywordings, as: :keywordable, dependent: :destroy
  has_many :keywords, through: :keywordings

  belongs_to :parent, class_name: "Entity"
  has_many :children, class_name: "Entity", foreign_key: "parent_id"

  # Validations
  validates :name, presence: true

  # Scopes
  default_scope -> {
    order('name ASC')
  }

  accepts_nested_attributes_for :contact

  alias_method :all_mappings, :mappings

  def to_s
    name
  end

  def has_user? user
    users.exists? user
  end

  def channels_mappings
    channels.map(&:channel_mappings)
  end

  def add_keyword(keyword)
    keywords << keyword
  end

  def remove_keyword(keyword)
    keywordings.where(keyword_id: keyword.id).destroy_all
  end

end
