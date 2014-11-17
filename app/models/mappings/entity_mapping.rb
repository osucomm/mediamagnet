class EntityMapping < Mapping

  # Set of all tags for an entity that are mapped in its channels.
  def entity_channels_tags
    if mappable_type == 'Entity'
      mappable.channels_mappings.map(&:tag)
    end
  end

 
end
