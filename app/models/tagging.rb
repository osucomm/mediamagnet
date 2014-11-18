class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :keyword
  belongs_to :taggable, polymorphic: true
  delegate :mappings, to: :taggable

  attr_accessor :tag_text

  after_initialize :get_tag_from_tag_text
  before_save :assign_tag_from_keyword
  before_save :assign_keyword_from_mapping

  scope :by_mappable, ->(mappable) {
    where(taggable_id: mappable.items.map(&:id)).where(taggable_type: 'Item')
  }

  scope :by_tag, ->(tag) {
    where(tag_id: tag.id)
  }

  private

  def get_tag_from_tag_text
    unless tag
      self.tag = Tag.create_from_text(tag_text) if tag_text.present?
    end
  end

  def assign_tag_from_keyword
    if tag.nil? && keyword.present?
      self.tag = Tag.from_text(keyword.name)
    end
  end

  def get_keyword_from_mappings
    mappings.to_a.keep_if do |mapping|
      mapping.tag_id == tag.id
    end.first.try(:keyword)
  end

  # Update keyword to reflect what the mapping says it should be.
  def assign_keyword_from_mapping
    self.keyword = Keyword.where(name: tag.name).first
    unless keyword || mappings.nil?
      self.keyword = get_keyword_from_mappings
    end
  end

end
