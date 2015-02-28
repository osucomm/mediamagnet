attributes :id, :name, :type, :service_identifier, :primary, :url, :entity_id
attribute :avatar_url => :avatar

child :keywords, object_root: false do
  extends 'api/v1/keywords/_keyword'
end
