class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :item
  delegate :mappings, to: :item

  attr_accessor :tag_text

  after_initialize :get_tag_from_tag_text
  after_create :add_keywords_to_item
  before_destroy :remove_keywords_from_item

  scope :by_mappable, ->(mappable) {
    where(item_id: mappable.items.map(&:id)).where(taggable_type: 'Item')
  }

  scope :by_tag, ->(tag) {
    where(tag_id: tag.id)
  }

  private

  def get_tag_from_tag_text
    # TODO Make better.
    if tag_id.nil?
      self.tag = Tag.create_from_text(tag_text) if tag_text.present?
    end
  end

  def add_keywords_to_item
    CreateKeywordingService.new(item, tag).execute
  end

  def remove_keywords_from_item
    keyword = Keyword.where(name: tag.name).first
    item.remove_keyword(Keyword.where(name: tag.name).first) if keyword

    # Assign keywords from mappings on our tag.
    mappings.each do |mapping|
      item.remove_keyword(mapping.keyword) if mapping.tag_id == tag.id
    end
  end

end
