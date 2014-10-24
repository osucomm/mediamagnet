class Item < ActiveRecord::Base
  belongs_to :channel
  has_one :entity, through: :channel
  has_many :assets
  has_and_belongs_to_many :keywords
end
