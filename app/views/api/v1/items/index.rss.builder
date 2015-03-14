xml.channel do

  render(:partial => 'api/v1/shared/rss_channel', :locals => {:x => xml, :result => @items, :channel => @channel })

  for item in @items
    xml.item do
      if item.title.present? or item.description.present?
        xml.title item.title unless item.title.blank?
        xml.description item.description unless item.description.blank?
      else
        xml.description excerpt_for(item)
      end

      if item.content.present?
        xml.content :encoded do
          xml.cdata! content(item)
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
      item.custom_tags.each do |tag|
        xml.category tag.name, domain: 'mm-custom'
      end

      item.assets.each do |asset|
        if asset.size.present?
          xml.enclosure url: asset.url, length: asset.size, type: asset.mime
        else
          xml.enclosure url: asset.url, type: asset.mime
        end
      end

    end
  end
end
