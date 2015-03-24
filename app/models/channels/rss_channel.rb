class RssChannel < Channel
  class << self
    def type_name
      'RSS'
    end

    def icon
      'rss'
    end
    def unicode_icon
      'f09e'
    end
  end

  def service_id_name
    'Feed URL'
  end

  def refresh_items
    web_items = client.entries

    web_items.each do |web_item|
      source_identifier = web_item.entry_id
      source_identifier ||= web_item.url
      unless items.where(source_identifier: source_identifier).exists?
        i = items.create(
          source_identifier: source_identifier,
          title: web_item.title,
          content: web_item.content,
          description: web_item.summary,
          link: Link.where(url: web_item.url).first_or_create,
          published_at: web_item.published,
          digest: Digest::SHA256.base64digest(web_item.title.to_s + web_item.content.to_s + web_item.summary.to_s)
        )
        i.assets.build(url: web_item.image) if web_item.image
        i.tag_names = (web_item.categories) if web_item.categories
        i.keywords << all_keywords
        if web_item.start_date
          event = i.events.build(
            start_date: web_item.start_date,
            end_date: web_item.end_date,
          )
          event.location = Location.where(location: web_item.location).first_or_create
          event.save
        end
        i.save
      end
    end
    log_refresh
  end

  def service_identifier_validator
    unless service_identifier_is_valid?
      errors.add :service_identifier, " must be a valid #{service_id_name.downcase}. <a href=\"http://validator.w3.org/feed/check.cgi?url=#{CGI.escape service_identifier}\">Click here to troubleshoot this feed</a>".html_safe
    end
  end

  def service_url
    url || service_identifier
  end

  private

  def client
    @client ||= (
        f = Feedjira::Feed
        f.fetch_and_parse(service_identifier)
    )
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
