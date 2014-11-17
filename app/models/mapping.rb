class Mapping < ActiveRecord::Base
  belongs_to :mappable, polymorphic: true
  belongs_to :tag
  belongs_to :keyword

  validates :keyword_id, :tag_id, :mappable_id, presence: true
  validates :tag_id, uniqueness: { scope: [:mappable_id, :mappable_type] }

  attr_accessor :tag_text

  before_validation :get_tag_from_tag_text

  after_create :update_taggings_for_mappable

  before_destroy :remove_keyword_taggings_for_mappable

  private

  def get_tag_from_tag_text
    unless tag || tag_text.nil?
      self.tag = Tag.create_from_text(tag_text)
    end
  end

 def update_taggings_for_mappable
    # TODO: Make this not update taggings when an entity mapping is created
    # and there is a corresponding (i.e., same tag) mapping on the channels.
    # if it's a new tag, don't do anything
    #
    # Get all items that are tagged with our new tag_id
    # 

    unless entity_channels_mappings.map(&:tag).include?(tag)
      Tagging.by_mappable(mappable).by_tag(tag).
        update_all(keyword_id: keyword.id)
    end
  end

  def remove_keyword_taggings_for_mappable
    if mappable_type == 'Channel' && 
        new_keyword_id = mappable.parent_mappings.where(tag_id: tag.id).first.try(:keyword_id)
      Tagging.by_mappable(mappable).by_tag(tag).
        update_all(keyword_id: new_keyword_id)
    end
  end

end
