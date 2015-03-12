class Mapping < ActiveRecord::Base

  # STI types
  TYPES = [ChannelMapping,EntityMapping]

  belongs_to :mappable, polymorphic: true
  belongs_to :tag
  belongs_to :keyword

  validates :keyword_id, :tag_id, :mappable_id, presence: true

  attr_accessor :tag_text

  before_validation :get_tag_from_tag_text
  after_create :add_keyword_to_items
  before_destroy :remove_keyword_from_items

  class << self
    def type_name
      self.name.sub('Mapping', '')
    end
    def help_text
      <<-EOT
        Mappings allow you to translate hashtags, categories and tags from your 
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

  def add_keyword_to_items
    items = mappable.items.eager
    items.each do |item|
      if item.custom_tags.include?(tag)
        item.keywords << keyword
        item.update_es_record
      end
    end
  end
  handle_asynchronously :add_keyword_to_items

  def remove_keyword_from_items
    mappable.items.each do |item|
      item.remove_keyword(keyword) if item.custom_tags.include?(tag)
    end
  end


end
