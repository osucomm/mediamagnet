class Entity < ActiveRecord::Base
  # Associations
  has_one :manifest
  has_many :channels
  has_many :items, through: :channels

  # Validations
  validates :name, presence: true

end
