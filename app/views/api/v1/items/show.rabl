object false
cache @item

child @item, object_root: false do
  extends 'api/v1/items/_item'

  child :channel => :channel do
    extends 'api/v1/channels/_channel'
  end

  child :entity => :entity do
    extends 'api/v1/entities/_entity'
  end

  child :events, object_root: false do
    extends 'api/v1/events/_event'
  end

  node(:links) { |i| i.links.to_a }
end

node (:meta) do
  meta(@item)
end
