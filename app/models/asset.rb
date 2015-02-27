class Asset < ActiveRecord::Base
  belongs_to :item

  before_validation :set_metadata

  class << self
    def help_text
      <<-EOT
        Assets are images or attachments found on the item from the source 
        system; photos from Instagram are assets.
      EOT
    end
  end

  private

  def set_metadata
    response = open url
    self.mime = response.content_type
    self.size = response.size
  end

end
