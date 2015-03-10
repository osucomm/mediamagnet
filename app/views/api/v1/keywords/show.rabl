object false
cache @keyword

child @keyword, object_root: false do
  extends 'api/v1/keywords/_keyword'
  attributes :display_name, :description
end

node (:meta) do
  meta(@keyword)
end
