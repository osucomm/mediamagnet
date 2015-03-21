class Link < ActiveRecord::Base
  belongs_to :item
  has_and_belongs_to_many :items

  PATTERN = /https?:\/\/[\da-z\.-]+\.[a-z\.]{2,6}[\/\w\.-]*\/?/

  def to_s
    url
  end

  class << self
    def resolve_uri(url, last_url = nil)

      # If it's an absolute URL, use last known host. [RFC3986], Section 4.2
      if (url.match PATTERN).nil?
        url = last_url.host + url.to_s
      end

      uri = URI(URI.encode(url.strip))
      return_url = ''

      begin
        Net::HTTP.start(uri.host, uri.port, open_timeout: 10,
                          :use_ssl => uri.scheme == 'https') do |http|
          begin
            request = Net::HTTP::Get.new uri
            response = http.request request # Net::HTTPResponse object
            if response.code.to_s.match(/^3/)
              return_url = resolve_uri(response['location'], uri)
            elsif response.code.to_s.match(/^2/)
              return_url = response.uri.to_s
            else
              return_url = nil
            end
          rescue 
          end
        end
      rescue 
        return_url = nil
        logger.warn "Could not open #{uri.to_s}"
      end
    return_url
    end

    def is_uri?(uri)
      begin
        URI.parse(uri)
      rescue
        false
      end
    end
  end

end
