class WebChannel < Channel
  class << self
    def type_name
      'Website'
    end
  end

  def service_id_name
    'Feed URL'
  end

  def run
    web_items = RSS::Parser.parse(service_identifier).items

    web_items.each do |web_item|
      unless items.where(guid: web_item.guid.content).exists?
        item = items.create(
          guid: web_item.guid.content,
          title: web_item.title,
          description: web_item.description,
          link: web_item.link,
          published_at: web_item.pubDate
        )
        item.add_keywords(web_item.categories.map(&:content))
      end
    end
    super
  end

end
