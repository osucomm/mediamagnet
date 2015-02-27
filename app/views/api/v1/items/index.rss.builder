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
    xml.image do
      xml.url @channel.avatar_url.present? ? @channel.avatar_url : image_url('osu-32px-stacked.png')
      xml.title @channel.name
      xml.link channel_url(@channel)
    end

  else
    xml.title "Media Magnet"
    xml.description "Aggregated content from Media Magnet"
    xml.link items_url
    xml.dc :publisher, "The Ohio State University"
    xml.image do
      xml.url image_url('osu-32px-stacked.png')
      xml.title "Media Magnet"
      xml.link items_url
    end
  end

  xml.atom :link, href: request.original_url, rel: "self", type: "application/rss+xml"
  xml.copyright "Copyright #{Time.now.year}, The Ohio State University"

  for item in @items
    xml.item do
      if item.title.present? or item.description.present?
        xml.title item.title unless item.title.blank?
        xml.description item.description unless item.description.blank?
      else
        xml.title excerpt_for(item)
      end

      if item.content.present?
        xml.content :encoded do
          xml.cdata! item.content
        end
      end

      xml.pubDate item.published_at.to_s(:rfc822)
      xml.link item.link
      xml.guid item.guid, isPermaLink: 'false'
      xml.source item.channel_name, url: item.channel.url
      xml.dc :type, item.channel_type
      if item.channel.display_contact && item.channel.display_contact.display_name.present?
        xml.dc :publisher, item.channel.display_contact.display_name
      end

      item.keywords.each do |keyword|
        xml.category keyword.name, domain: 'mm-keyword'
      end

      item.assets.each do |asset|
        xml.enclosure url: asset.url, type: asset.mime
      end

    end
  end
end
