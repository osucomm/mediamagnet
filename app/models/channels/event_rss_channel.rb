class EventRssChannel < Channel
  class << self
    def type_name
      'Events RSS feed'
    end
  end

  def icon
    'calendar'
  end

  def service_id_name
    'Feed URL'
  end

  def refresh_items
    client.entries.each do |entry|
      unless items.where(guid: entry.entry_id).exists?
        item = items.create(
          guid: entry.entry_id,
          title: entry.title,
          content: entry.content,
          description: entry.summary,
          link: Link.where(url: entry.url).first_or_create,
          published_at: entry.published
        )
        item.tag_names = (entry.categories) if entry.categories
        i.keywords << all_keywords
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

  def service_identifier_validator
    unless service_identifier_is_valid?
      errors.add :service_identifier, " must be a valid #{service_id_name.downcase}. <a href=\"http://validator.w3.org/feed/check.cgi?url=#{CGI.escape service_identifier}\">Click here to troubleshoot this feed</a>".html_safe
    end
  end

  private

  def client
    @client ||= Feedjira::Feed.fetch_and_parse(service_identifier)
  end

  def service_account
    if client.class == Fixnum || client.class == Hash
      return nil
    end
    return client
  end

  def get_info
    if new_record? && service_identifier_is_valid?
      self.name = client.title
      self.description = client.description
      self.url = client.feed_url
    end
  end

end
