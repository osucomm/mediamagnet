class Event < ActiveRecord::Base
  belongs_to :location

  class << self
    def help_text
      <<-EOT
        Items may have associated events which have start date/time, end date/time
        and location.
      EOT
    end
  end

  def location_name
    location.location if location
  end
end
