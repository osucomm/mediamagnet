object root: { root: 'result' } if request.format.xml?
cache @event

child @event, object_root: false do
  extends 'api/v1/events/_event'
end

node (:meta) do
  meta(@event)
end
