class Entity < ActiveRecord::Base
  # Associations
  has_one :manifest
  has_many :channels
  has_many :items, through: :channels
  has_and_belongs_to_many :users

  # Validations
  validates :name, presence: true

end
