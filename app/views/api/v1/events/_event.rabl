attributes :id, :start_date, :end_date

child :item do
  extends 'api/v1/items/_item'
end

child :location do
  attributes :location, :latitude, :longitude
end
