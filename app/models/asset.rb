class Asset < ActiveRecord::Base
  belongs_to :item

  before_validation :set_metadata

  scope :videos, -> { where("mime like 'video%'") }

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
    if url =~ /\ /
      self.url = URI.encode(url)
    end
    real_url = Link.resolve_uri(url)
    response = Link.response(real_url)
    self.mime = response.content_type
    self.size = response.content_length
  end

end
