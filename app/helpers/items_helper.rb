module ItemsHelper

  def itemable_items_path(itemable)
    if itemable.class.name =~ /Channel$/
      channel_items_path(channel_id: itemable.id)
    else
      items_path(entity_id: itemable.id)
    end
  end

  def excerpt(item, length=140)
    truncate(strip_tags(item.to_s.html_safe).html_safe, length: length)
  end

  def content(item)
    if item.content.nil?
    # Channel-specific html
      case item.channel_type
      when 'youtube'
        "<iframe src=\"https://www.youtube.com/embed/#{item.guid}\" />".html_safe
      when 'instagram'
        "<img src=\"https://www.youtube.com/embed/#{item.assets.first.url}\" />".html_safe
      else
        auto_link(item.to_s)
      end
    else
      item.content.html_safe
    end
  end
end
