object false
cache @event

child @event, object_root: false do
  extends 'api/v1/events/_event'

  child :item do
    extends 'api/v1/entities/_item'
  end
end

node (:meta) do
  meta(@event)
end
