xml.channel do

  render(:partial => 'api/v1/shared/rss_channel', :locals => {:x => xml, :result => @events, :channel => @channel })

  for event in @events
    xml.item do
      if event.title.present? or event.description.present?
        xml.title event.title unless event.title.blank?
        xml.description event.description unless event.description.blank?
      else
        xml.description excerpt_for(event.item)
      end

      if event.content.present?
        xml.content :encoded do
          xml.cdata! content(event.item)
        end
      end

      xml.ev :startdate, event.start_date.to_s(:rfc822)
      xml.ev :enddate, event.start_date.to_s(:rfc822)
      xml.ev :location, event.location_name
      xml.pubDate event.item.published_at.to_s(:rfc822)
      xml.link event.link
      xml.guid event.item.guid, isPermaLink: 'false'
      xml.source event.item.channel_name, url: event.item.channel.service_url
      xml.dc :type, event.item.channel_type
      if event.item.channel.display_contact && event.item.channel.display_contact.display_name.present?
        xml.dc :publisher, event.item.channel.display_contact.display_name
      end

      event.item.keywords.each do |keyword|
        xml.category keyword.name, domain: 'mm-keyword'
      end
      event.item.custom_tags.each do |tag|
        xml.category tag.name, domain: 'mm-custom'
      end

      event.item.assets.each do |asset|
        xml.media :content, media_attributes(asset)
      end

    end
  end
end
