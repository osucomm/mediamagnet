class Location < ActiveRecord::Base
  has_many :events
  
  def to_s
    location
  end
end
