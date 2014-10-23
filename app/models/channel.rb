class Channel < ActiveRecord::Base
  # Associations
  belongs_to :entity

  has_many :items

  # Validations
  validates :name, presence: true
  validates :service_identifier, presence: true

end
