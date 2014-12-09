class ItemLink < ActiveRecord::Base
  belongs_to :item
  belongs_to :link
end
