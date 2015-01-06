class Mapping < ActiveRecord::Base

  # STI types
  TYPES = [ChannelMapping,EntityMapping]

  belongs_to :mappable, polymorphic: true
  belongs_to :tag
  belongs_to :keyword

  validates :keyword_id, :tag_id, :mappable_id, presence: true
  validates :tag_id, uniqueness: { scope: [:mappable_id, :mappable_type, :keyword_id] }

  attr_accessor :tag_text

  before_validation :get_tag_from_tag_text

  class << self
    def type_name
      self.name.sub('Mapping', '')
    end
    def help_text
      <<-EOT
        Mappings allow you to translate hastags, categories and tags from your 
        site into Media Magnet keywords. Mappings may be applied to channels, or 
        to their entities, which will provide a default map for all channels in 
        that entity.

        For social media hastags (Twitter, Instagram, etc.) you should not 
        include the leading '#'.
      EOT
    end

    def keywords
      all.map(&:keyword).flatten.uniq
    end
  end

  def policy_class
    MappingPolicy
  end

  private

  def get_tag_from_tag_text
    unless tag || tag_text.nil?
      self.tag = Tag.create_from_text(tag_text)
    end
  end


end
