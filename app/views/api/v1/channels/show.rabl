cache @channel
object @channel => :channels

attributes :id, :name, :service_identifier
node(:entity) { |c| c.entity }
