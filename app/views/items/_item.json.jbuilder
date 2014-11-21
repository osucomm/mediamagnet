json.title item.title
json.description item.description
json.link item.link
json.keywords item.all_keywords.map(&:name)
json.channel do 
  json.partial! 'channels/channel', channel: item.channel
end
