cache @event
object @event => :events
extends 'api/v1/events/_event'

child :item do
  extends 'api/v1/entities/_item'
end
