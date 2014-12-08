class EventChannel < Channel
  class << self
    def type_name
      'Events feed'
    end
  end

  def icon
    'calendar'
  end

  def service_id_name
    'Feed URL'
  end

  def client
    @client ||= Feedjira::Feed.fetch_and_parse(service_identifier)
  end

  def refresh_items
    client.entries.each do |entry|
      unless items.where(guid: entry.entry_id).exists?
        item = items.create(
          guid: entry.entry_id,
          title: entry.title,
          content: entry.content,
          description: entry.summary,
          link: entry.url,
          published_at: entry.published
        )
        item.tag_names = (entry.categories) if entry.categories
        e = item.events.build(
          start_date: entry.start_date,
          end_date: entry.end_date,
        )
        e.location = Location.where(location: entry.location).first_or_create
        e.save
      end
    end
    log_refresh
  end
  handle_asynchronously :refresh_items

end
