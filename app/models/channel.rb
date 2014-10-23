class Channel < ActiveRecord::Base
  # Associations
  belongs_to :entity

  # Validations
  validates :name, presence: true
  validates :service_identifier, presence: true

end
