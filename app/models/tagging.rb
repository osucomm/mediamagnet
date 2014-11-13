class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :keyword
  belongs_to :taggable, polymorphic: true
  delegate :mappings, to: :taggable

  attr_accessor :tag_text

  after_initialize :get_tag_from_tag_text
  before_save :assign_keyword_from_mapping

  private

  def get_tag_from_tag_text
    unless tag
      self.tag = Tag.where(name: tag_text.downcase).first_or_initialize
    end
  end

  # Update keyword to reflect what the mapping says it should be.
  def assign_keyword_from_mapping
    self.keyword = Keyword.where(name: tag.name).first
    unless keyword
      self.keyword = mappings.where(tag_id: tag.id).first.try(:keyword)
    end
  end

end
