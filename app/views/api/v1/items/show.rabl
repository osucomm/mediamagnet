object @item => :items

attributes :id, :guid, :title, :description, :content, :link, :published_at
node(:href) { |i| item_url(i) }

child :assets, object_root: false do
  attributes :mime, :url
end

node(:links) { |i| i.links.map(&:url)  }

child :keywords, object_root: false do
  attributes :id, :name
  node(:category) { |k| k.category.try(:name) }
end

attribute :tag_names => :tags
