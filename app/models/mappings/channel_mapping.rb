class ChannelMapping < Mapping

  before_destroy :remove_keyword_taggings

  private

  def remove_keyword_taggings
    if new_keyword_id = mappable.entity_mappings.where(tag_id: tag.id).first.try(:keyword_id)
      Tagging.by_mappable(mappable).by_tag(tag).
        update_all(keyword_id: new_keyword_id)
    end
  end


end
