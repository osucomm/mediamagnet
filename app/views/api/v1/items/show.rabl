cache @item
object @item => :items

attributes :id, :guid, :title, :channel_type, :tags, :description, :link, :published_at
node(:href) { |i| item_url(i) }
node(:excerpt) { |i| exceprt(i) }
node(:content) { |i| content(i) }

child :assets, object_root: false do
  attributes :mime, :url
end

child :keywords, object_root: false do
  attributes :id, :name
  node(:category) { |k| k.category.try(:name) }
end
