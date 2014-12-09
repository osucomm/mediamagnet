class Link < ActiveRecord::Base
  has_many :item_links
  has_many :items, through: :item_links
  belongs_to :item

  PATTERN = /https?:\/\/[\da-z\.-]+\.[a-z\.]{2,6}[\/\w\.-]*\/?/

  def to_s
    url
  end

  class << self
    def resolve_uri(url)
      uri = URI(url.strip)
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
  end

end
