json.id item.id
json.guid item.guid
json.title item.title
json.description item.description
json.content item.content
json.service_id_name
json.href url_for(item)
json.link item.link
json.assets do
  json.array! item.assets do |asset|
    json.id asset.id
    json.mime asset.mime
    json.url asset.url
  end
end
json.keywords do
  json.array! item.keywords do |keyword|
    json.id keyword.id
    json.name keyword.name
    json.href url_for(keyword)
  end
end
json.events do
  json.array! item.events do |event|
    json.start_date event.start_date
    json.end_date event.end_date
    json.location event.location_name
  end
end
json.channel do
  json.id item.channel.id
  json.name item.channel.name
  json.href url_for(item.channel)
end
