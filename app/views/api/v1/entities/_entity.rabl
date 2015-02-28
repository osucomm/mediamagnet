attributes :id, :name, :description, :link

child :keywords, object_root: false do
  extends 'api/v1/keywords/_keyword'
end
