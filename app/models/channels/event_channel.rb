class EventChannel < Channel
  class << self
    def display_name
      'Events feed'
    end
  end

  def service_id_name
    'Feed URL'
  end
end
