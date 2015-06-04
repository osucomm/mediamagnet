attributes :id, :start_date, :end_date, :all_day

glue :item do
  attributes :id => :item_id
  attributes :source_identifier, :title, :tags, :description, :link, :published_at, :channel_id
  node(:href) { |i| item_url(i) }
  node(:excerpt) { |i| excerpt_for(i) }
  node(:content) { |i| content(i) }

  child :assets, object_root: false do
    attributes :mime, :url, :size
  end

  child :keywords, object_root: false do
    extends 'api/v1/keywords/_keyword'
  end
end

child :location do
  attributes :location, :latitude, :longitude
end
