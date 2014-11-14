class Entity < ActiveRecord::Base
  # Associations
  has_one :contact, as: :contactable, dependent: :destroy
  has_one :manifest
  has_many :channels
  has_many :items, through: :channels
  has_many :mappings, as: :mappable
  has_and_belongs_to_many :users

  has_many :taggings, as: :taggable
  has_many :tags, through: :taggings
  has_many :keywords, through: :taggings

  belongs_to :parent, class_name: "Entity"
  has_many :children, class_name: "Entity", foreign_key: "parent_id"

  alias_method :all_mappings, :mappings

  # Validations
  validates :name, presence: true

  # Scopes
  default_scope -> {
    order('name ASC')
  }

  accepts_nested_attributes_for :contact

  def to_s
    name
  end

  def has_user? user
    users.exists? user
  end

end
