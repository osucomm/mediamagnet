object root: { root: 'result' } if request.format.xml?
cache @items

if @items.present?
  child @items, object_root: false do
    extends 'api/v1/items/_item'
  end
else
  child @items => :items
end

node (:meta) do
  meta(@items)
end
