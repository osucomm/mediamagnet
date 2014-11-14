class Mapping < ActiveRecord::Base
  belongs_to :mappable, polymorphic: true
  belongs_to :tag
  belongs_to :keyword

  validates :keyword_id, :tag_id, :mappable_id, presence: true
  validates :tag_id, uniqueness: { scope: :mappable_id },
    message: 'should only map to one keyword'

  attr_accessor :tag_text

  before_validation :get_tag_from_tag_text
  before_validation :sti_base_class

  private

  def get_tag_from_tag_text
    unless tag || tag_text.nil?
      self.tag = Tag.from_text(tag_text)
    end
  end

  def sti_base_class
    self.mappable_type = self.mappable_type.safe_constantize.base_class.to_s
  end

end
