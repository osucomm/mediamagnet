class LocationResolver
  def initialize(location)
    @location = URI.encode(location)
  end

  def resolve
    unless @location.nil?
      base_url = 'http://newmedia.osu.edu/projects/osu_location/public/?q='
      response = HTTParty.get(base_url + @location).parsed_response
      JSON.parse(response).keep_if do |k,v|
        [:code, :name, :address, :latitude, :longitude].include?(k.to_sym)
      end
    end
  end
end
