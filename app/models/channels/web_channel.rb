class WebChannel < Channel
  class << self
    def display_name
      'Website'
    end
  end

  def service_id_name
    'Feed URL'
  end
end
