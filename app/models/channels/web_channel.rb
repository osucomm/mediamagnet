class WebChannel < Channel
  class << self
    def type_name
      'Website'
    end
  end

  def service_id_name
    'Feed URL'
  end

  def icon
    'rss'
  end

  def client
    @client ||= 
      begin
        f = Feedjira::Feed
        # f.add_common_feed_entry_element('guid', as: 'guida')
        f.fetch_and_parse(service_identifier)
      end
  end

  def refresh_items
    web_items = client.entries

    web_items.each do |web_item|
      unless items.where(guid: web_item.entry_id).exists?
        item = items.create(
          guid: web_item.entry_id,
          title: web_item.title,
          content: web_item.content,
          description: web_item.summary,
          link: web_item.url,
          published_at: web_item.published
        )
        item.tag_names = (web_item.categories) if web_item.categories
      end
    end
    super
  end

end
