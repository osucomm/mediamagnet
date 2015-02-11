module ItemsHelper

  def itemable_items_path(itemable)
    if itemable.class.name =~ /Channel$/
      channel_items_path(channel_id: itemable.id)
    else
      items_path(entity_id: itemable.id)
    end
  end

  def short_description(item)
    truncate(strip_tags(item.description.html_safe).html_safe, length: 150)
  end
end
