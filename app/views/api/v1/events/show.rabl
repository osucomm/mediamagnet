cache @event
object @event => :events

  attributes :id, :location, :start_date, :end_date
node(:item) { |e| e.item }
