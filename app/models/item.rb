class Item < ActiveRecord::Base
  belongs_to :channel
  has_one :entity, through: :channel
end
