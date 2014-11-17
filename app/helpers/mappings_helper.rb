module MappingsHelper

  def new_mapping_path(mappable)
    send("new_#{mappable.class.base_class.to_s.underscore}_mapping_path", {mappable_id: mappable.id, mappable_type: mappable.class.base_class})
  end

end
