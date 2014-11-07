class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :keyword
  belongs_to :taggable, polymorphic: true

  attr_accessor :tag_text

  before_save :get_tag_from_tag_text

  # Get mappings from taggable.

  private

  def get_tag_from_tag_text
    self.tag = Tag.where(name: tag_text.downcase).first_or_create
  end

end
