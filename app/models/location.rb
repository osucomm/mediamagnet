class Location < ActiveRecord::Base
  has_many :events
  
  def to_s
    location
  end

  def resolve_location
    loc = LocationResolver.new(location).resolve
    unless loc.empty?
      self.latitude = loc['latitude']
      self.longitude = loc['longitude']
      save
    end
  end
end
