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
      if (url.match PATTERN).nil? && last_url.present?
        url = last_url.host + url.to_s
      end

      uri = URI(URI.encode(self.decode(url.strip), /\[|\]|\ /))

      return_url = ''

      begin
        Net::HTTP.start(uri.host, uri.port, open_timeout: 10,
                          :use_ssl => uri.scheme == 'https') do |http|
          begin
            request = Net::HTTP::Head.new uri
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

    def response(url)
      uri = URI(URI.encode(url.strip))

      @response ||= Net::HTTP.start(uri.host, uri.port, open_timeout: 10,
                        :use_ssl => uri.scheme == 'https') do |http|
          request = Net::HTTP::Head.new uri
          response = http.request request # Net::HTTPResponse object
          response
      end
    end

    def is_uri?(uri)
      begin
        URI.parse(uri)
      rescue
        false
      end
    end

    def decode(uri)
      another_round = URI.decode(uri)
      self.decode(another_round) if another_round != uri
      another_round
    end

  end

  def response_code
    response.code
  end

  def response_content_length
    response.length
  end

  def response_content_type
    response.length
  end

  private

  def response
    self.class.response(self.url)
  end

end
