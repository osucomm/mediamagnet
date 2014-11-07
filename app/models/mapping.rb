class Mapping < ActiveRecord::Base
  belongs_to :mappable, polymorphic: true
  belongs_to :item
  belongs_to :keyword

  def tag

  end
end
