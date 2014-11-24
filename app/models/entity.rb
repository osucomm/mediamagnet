class Entity < ActiveRecord::Base
  include Taggable

  # Associations
  has_one :contact, as: :contactable, dependent: :destroy
  has_one :manifest
  has_many :channels, dependent: :destroy
  has_many :items, through: :channels
  has_many :entity_mappings, as: :mappable, dependent: :destroy
  has_and_belongs_to_many :users

  belongs_to :parent, class_name: "Entity"
  has_many :children, class_name: "Entity", foreign_key: "parent_id"

  # Validations
  validates :name, presence: true

  # Scopes
  default_scope -> {
    order('name ASC')
  }

  accepts_nested_attributes_for :contact

  alias_method :mappings, :entity_mappings

  def to_s
    name
  end

  def has_user? user
    users.exists? user
  end

  def channels_mappings
    channels.map(&:channel_mappings)
  end


end
