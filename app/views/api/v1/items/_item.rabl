attributes :id, :guid, :title, :channel_type, :tags, :description, :link, :published_at, :channel_id
node(:href) { |i| item_url(i) }
node(:excerpt) { |i| excerpt_for(i) }
node(:content) { |i| content(i) }

child :assets, object_root: false do
  attributes :mime, :url, :size
end

child :keywords, object_root: false do
  extends 'api/v1/keywords/_keyword'
end
