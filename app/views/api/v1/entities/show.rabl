cache @entity
object @entity => :entity
extends 'api/v1/entities/_entity'

child :mappings, object_root: false do
  extends 'api/v1/mappings/_mapping'
end

child :contact, object_root: false do
  extends 'api/v1/contacts/_contact'
end

child :channels, object_root: false do
  extends 'api/v1/channels/_channel'
end
