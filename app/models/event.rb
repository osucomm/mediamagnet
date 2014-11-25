class Event < ActiveRecord::Base
  belongs_to :location

  def location_name
    location.location if location
  end
end
