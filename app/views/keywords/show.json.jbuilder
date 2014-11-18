json.title item.title
json.description item.description
json.link item.link
json.channel do 
  json.partial! 'channels/channel', channel: item.channel
end
