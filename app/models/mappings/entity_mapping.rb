class EntityMapping < Mapping

  # Set of all tags for an entity that are mapped in its channels.
  def entity_channels_tags
    entity.channels_mappings.map(&:tag)
  end

end
