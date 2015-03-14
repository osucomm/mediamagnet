if channel
  x.title channel.name
  x.description channel.description
  x.link channel_url(channel)
  if channel.display_contact && channel.display_contact.display_name.present?
    x.dc :publisher, channel.display_contact.display_name
  end
  x.dc :type, channel.type
  channel.keywords.each do |keyword|
    x.category keyword.name, domain: 'mm-keyword'
  end
  x.image do
    x.url channel.avatar_url.present? ? channel.avatar_url : image_url('osu-32px-stacked.png')
    x.title channel.name
    x.link channel_url(channel)
  end

else
  x.title "Media Magnet"
  x.description "Aggregated content from Media Magnet"
  x.link items_url
  x.dc :publisher, "The Ohio State University"
  x.image do
    x.url image_url('osu-32px-stacked.png')
    x.title "Media Magnet"
    x.link items_url
  end
end

x.copyright "Copyright #{Time.now.year}, The Ohio State University"

x.atom :link, href: self_url, rel: "self", type: "application/rss+xml"
x.atom :link, href: first_page_url, rel: "first", type: "application/rss+xml"
if previous_page_url(result)
  x.atom :link, href: previous_page_url(result), rel: "previous", type: "application/rss+xml"
end
if next_page_url(result)
  x.atom :link, href: next_page_url(result), rel: "next", type: "application/rss+xml"
end
x.atom :link, href: last_page_url(result), rel: "last", type: "application/rss+xml"
