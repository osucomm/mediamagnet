object false
cache @channels

if @channels.present?
  child @channels, object_root: false do
    extends 'api/v1/channels/_channel'
  end
else
  child @channels => :channels
end

node (:meta) do
  meta(@channels)
end
