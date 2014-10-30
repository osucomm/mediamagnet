class Keyword < ActiveRecord::Base
  has_and_belongs_to_many :items
  has_and_belongs_to_many :channels
  has_and_belongs_to_many :entities

  enum category: { audience: 0, college: 1, location: 2 }

  # Validations
  validates :name, presence: true
  validates :display_name, presence: true
end
