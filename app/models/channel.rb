class Channel < ActiveRecord::Base
  # Associations
  belongs_to :entity
  has_one :contact, as: :contactable
  has_many :items
  has_and_belongs_to_many :keywords
  has_and_belongs_to_many :tags

  # Validations
  validates :name, presence: true
  validates :service_identifier, presence: true

end
