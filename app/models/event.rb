class Event < ActiveRecord::Base
  belongs_to :location
  belongs_to :item

  delegate :title, :description, :content, :channel, :entity, :link, :excerpt, to: :item

  scope :ordered, -> {
    order('start_date ASC')
  }

  scope :upcoming, -> {
    where('start_date > ?', Time.now)
  }


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
