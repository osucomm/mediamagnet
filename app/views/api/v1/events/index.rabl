object root: { root: 'result' } if request.format.xml?
cache @events

if @events.present?
  child @events, root: 'events', object_root: false do
    extends 'api/v1/events/_event'
  end
else
  child @events => :events
end

node (:meta) do
  meta(@events)
end
