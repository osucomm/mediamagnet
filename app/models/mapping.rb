class Mapping < ActiveRecord::Base
  belongs_to :mappable, polymorphic: true
  belongs_to :tag
  belongs_to :keyword
end
