xml.channel do
  if @channel
    xml.title @channel.name
    xml.description do
      xml.cdata! @channel.description
    end
    xml.link channel_url(@channel)
    xml.dc :type, @channel.type
    @channel.keywords.each do |keyword|
      xml.category keyword.name, domain: 'mm-keyword'
    end

  else
    xml.title "Media Magnet"
    xml.description do
      xml.cdata! "Aggregated content from Media Magnet"
    end
    xml.link items_url
  end

  xml.atom :link, href: request.original_url, rel: "self", type: "application/rss+xml"
  xml.copyright "Copyright #{Time.now.year}, The Ohio State University"

  for item in @items
    xml.item do
      xml.title item.title if item.title
      if item.description
        xml.description do
          xml.cdata! item.description
        end
      end
      xml.pubDate item.published_at.to_s(:rfc822)
      xml.link item.link
      xml.guid item.guid, isPermaLink: 'false'
      xml.source item.channel.name, url: channel_items_url(item.channel.id, format: :rss)
      xml.dc :type, item.channel.type

      item.keywords.each do |keyword|
        xml.category keyword.name, domain: 'mm-keyword'
      end
    end
  end
end