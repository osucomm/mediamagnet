module ItemsHelper
  def itemable_items_path(itemable)
    if itemable.class.name =~ /Channel$/
      channel_items_path(channel_id: itemable.id)
    else
      items_path(entity_id: itemable.id)
    end
  end

  def excerpt_for(item, length=140)

    string = if item.to_s == item.guid
               "#{item.channel_type.titleize} from #{item.channel.service_identifier} on #{time_or_dash(item.published_at, :pretty_long)}"
             else
               item.to_s
             end.html_safe

    truncate(strip_tags(string).html_safe, length: length)
  end

  def content(item)
    if item.content.nil?
    # Channel-specific html
      case item.channel_type
      when 'youtube'
        tag(:iframe, src: "https://www.youtube.com/embed/#{item.guid}")
      when 'instagram'
        image_tag(item.assets.first.url)
      else
        auto_link(item.to_s)
      end
    else
      item.content.html_safe
    end
  end
end
