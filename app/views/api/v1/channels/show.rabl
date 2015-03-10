object false
cache @channel

child @channel, root: 'channel', object_root: false do
  extends 'api/v1/channels/_channel'

  child :all_mappings_distinct, object_root: false do
    extends 'api/v1/mappings/_mapping'
  end

  child :display_contact, object_root: false do
    extends 'api/v1/contacts/_contact'
  end

  child :entity do
    extends 'api/v1/entities/_entity'
  end
end

node (:meta) do
  meta(@channel)
end
