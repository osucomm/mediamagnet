object false
cache @entities

if @entities.present?
  child @entities, root: 'entities', object_root: false do
    extends 'api/v1/entities/_entity'
  end
else
  child @entities => :entities
end

node (:meta) do
  meta(@entities)
end
