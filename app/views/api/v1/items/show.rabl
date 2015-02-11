object @item => :items

attributes :id, :guid, :title, :description, :content, :link
node(:href) { |i| item_url(i) }

child :assets do
  attributes :id, :mime, :url
end




