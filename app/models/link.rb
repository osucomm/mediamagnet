class Link < ActiveRecord::Base
  belongs_to :item
  has_and_belongs_to_many :items

  PATTERN = /https?:\/\/[\da-z\.-]+\.[a-z\.]{2,6}[\/\w\.-]*\/?/

  def to_s
    url
  end

  class << self
    def resolve_uri(url)
      uri = URI(URI.encode(url.strip))
      return_url = ''

      Net::HTTP.start(uri.host, uri.port,
                        :use_ssl => uri.scheme == 'https') do |http|
          request = Net::HTTP::Get.new uri
          response = http.request request # Net::HTTPResponse object
          if response.code.to_s.match(/^3/)
            return_url = resolve_uri(response['location'])
          elsif response.code.to_s.match(/^2/)
            return_url = response.uri.to_s
          else
            return_url = nil
          end

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
