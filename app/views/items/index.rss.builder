xml.channel do
  if @channel
    xml.title @channel.name
    xml.description @channel.description
    xml.link channel_url(@channel)
    if @channel.display_contact && @channel.display_contact.display_name.present?
      xml.dc :publisher, @channel.display_contact.display_name
    end
    xml.dc :type, @channel.type
    @channel.keywords.each do |keyword|
      xml.category keyword.name, domain: 'mm-keyword'
    end

  else
    xml.title "Media Magnet"
    xml.description "Aggregated content from Media Magnet"
    xml.link items_url
    xml.dc :publisher, "The Ohio State University"
  end

  xml.atom :link, href: request.original_url, rel: "self", type: "application/rss+xml"
  xml.copyright "Copyright #{Time.now.year}, The Ohio State University"

  for item in @items
    xml.item do
      xml.title item.title if item.title
      xml.description item.description if item.description
      xml.pubDate item.published_at.to_s(:rfc822)
      xml.link item.link
      xml.guid item.guid, isPermaLink: 'false'
      xml.source item.channel_name, url: channel_items_url(item.channel_id, format: :rss)
      xml.dc :type, item.type_name
      if item.channel.display_contact && item.channel.display_contact.display_name.present?
        xml.dc :publisher, item.channel.display_contact.display_name
      end

      item.keywords.each do |keyword|
        xml.category keyword.name, domain: 'mm-keyword'
      end
    end
  end
end
