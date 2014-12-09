class Link < ActiveRecord::Base
  has_many :item_links
  has_many :items, through: :item_links
  belongs_to :item

  def to_s
    url
  end

end
