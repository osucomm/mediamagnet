module ItemsHelper
  def itemable_items_path(itemable)
    if itemable.class.name =~ /Channel$/
      channel_items_path(channel_id: itemable.id, channel_type: itemable.type)
    else
      if itemable.channels.first.type == 'FundChannel'
        items_path(entity_id: itemable.id, channel_type: itemable.channels.first.type_name.downcase)
      else
        items_path(entity_id: itemable.id)
      end
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
      when 'youtube playlist'
        "<iframe width=\"640\" height=\"390\" src=\"https://www.youtube.com/embed/#{item.guid}\" frameborder=\"0\" allowfullscreen></iframe>".html_safe
      when 'instagram'
        image_tag(item.assets.first.url)
      when 'twitter'
        twitter_link(auto_link(item.description))
      else
        auto_link(item.to_long_string)
      end
    else
      item.content.html_safe
    end
  end

  def twitter_link(text)
    text.gsub(/\#[A-Za-z0-9]+/) do |hashtag| 
      "<a href=\"https://twitter.com/search/?q=#{hashtag.gsub('#', '%23')}\" title=\"#{hashtag} on twitter\">#{hashtag}</a>"
    end.gsub(/\@[A-Za-z0-9]+/) do |user|
      "<a href=\"https://twitter.com/#{user.gsub('@','')}\" title=\"#{user} on twitter\">#{user}</a>"
    end.html_safe
  end
end
