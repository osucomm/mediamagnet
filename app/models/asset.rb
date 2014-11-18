class Asset < ActiveRecord::Base
  belongs_to :item

  before_validation :get_mime_from_url

  class << self
    def get_mime(url)
      response = open url
      response.content_type
    end
  end

  private

  def get_mime_from_url
    self.mime = Asset.get_mime(url)
  end

end
