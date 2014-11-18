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
    @@client ||= RSS::Parser.parse(service_identifier)
  end

  def refresh_items
    web_items = client.items

    web_items.each do |web_item|
      unless items.where(guid: web_item.guid.content).exists?
        item = items.create(
          guid: web_item.guid.content,
          title: web_item.title,
          content: web_item.content_encoded,
          description: web_item.description,
          link: web_item.link,
          published_at: web_item.pubDate
        )
        item.tag_names = (web_item.categories.map(&:content)) if web_item.categories
      end
    end
    super
  end

end
