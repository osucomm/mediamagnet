class EntityMapping < Mapping

  after_create :update_taggings_for_mappable

  # Set of all tags for an entity that are mapped in its channels.
  def entity_channels_tags
    entity.channels_mappings.map(&:tag)
  end

  # After created, iterate over channels, and if they haven't already set
  # a mapping for this tag, update all of the items to vi
  def update_taggings_for_mappable
    mappable.channels.each do |channel|
      unless channel.mappings.map(&:tag).include?(tag)
        Tagging.by_mappable(channel).by_tag(tag).
          update_all(keyword_id: keyword.id)
      end
    end
  end


end
