attributes :id, :source_identifier, :title, :tags, :description, :link, :published_at, :channel_id
node(:href) { |i| item_url(i) }
node(:excerpt) { |i| excerpt_for(i) }
node(:content) { |i| content(i) }

child :assets, object_root: false do
  attributes :mime, :url, :size
end

child :channel => :channel do
  extends 'api/v1/channels/_channel'
end


child :keywords, object_root: false do
  extends 'api/v1/keywords/_keyword'
end
