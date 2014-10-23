class Manifest < ActiveRecord::Base
  # Associations
  belongs_to :entity

  # Validations
  validates :entity_id, presence: true
  validates :url, presence: true

end
