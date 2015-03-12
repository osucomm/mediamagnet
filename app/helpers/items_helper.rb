module ItemsHelper
  def itemable_items_path(itemable)
    if itemable.class.name =~ /Channel$/
      channel_items_path(channel_id: itemable.id)
    else
      items_path(entity_id: itemable.id)
    end
  end

  def excerpt_for(item, length=150)
    decoder = HTMLEntities.new

    string = if item.to_s == item.guid
               "#{item.channel_type.titleize} from #{item.channel.service_identifier} on #{time_or_dash(item.published_at, :pretty_long)}"
             else
               decoder.decode(item.to_s)
             end

    truncate(decoder.decode(strip_tags(string)), length: length, separator: ' ').html_safe
  end

  def content(item)
    if item.content.blank?
    # Channel-specific html
      case item.channel_type
      when 'youtube'
        tag(:iframe, src: "https://www.youtube.com/embed/#{item.guid}")
      when 'instagram'
        image_tag(item.assets.first.url)
      else
        auto_link(item.to_long_string)
      end
    else
      item.content.html_safe
    end
  end
end
