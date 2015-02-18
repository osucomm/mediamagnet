cache @item
object @item => :items

attributes :id, :guid, :title, :description, :content, :link
node(:href) { |i| item_url(i) }
node(:excerpt) { |i| i.to_s }
node(:links) { |i| i.links.map(&:url) }

child :assets do
  attributes :id, :mime, :url
end
