class EventChannel < Channel
  class << self
    def type_name
      'Events feed'
    end
  end

  def icon
    'calendar'
  end

  def service_id_name
    'Feed URL'
  end
end
