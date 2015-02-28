object @item => :item
extends 'api/v1/items/_item'
cache @item

child :channel => :channel do
  extends 'api/v1/channels/_channel'
end

child :events, object_root: false do
  extends 'api/v1/events/_event'
end

node(:links) { |i| i.links.to_a }
