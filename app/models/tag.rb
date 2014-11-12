class Tag < ActiveRecord::Base
  include LowercaseName
  has_many :taggings
  has_many :channels, through: :taggings, source: :taggable, source_type: "Channel"
  has_many :items, through: :taggings, source: :taggable, source_type: "Item"

  validate :name, unique: true
end
