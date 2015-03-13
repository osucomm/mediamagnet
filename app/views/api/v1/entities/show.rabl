object root: { root: 'result' } if request.format.xml?
cache @entity

child @entity, object_root: false do
  extends 'api/v1/entities/_entit'

  child :mappings, object_root: false do
    extends 'api/v1/mappings/_mapping'
  end

  child :contact, object_root: false do
    extends 'api/v1/contacts/_contact'
  end

  child :channels, object_root: false do
    extends 'api/v1/channels/_channel'
  end
end

node (:meta) do
  meta(@channel)
end
