class IcalendarChannel < Channel
  class << self
    def type_name
      'iCalendar'
    end
  end

  def icon
    'calendar'
  end

  def service_id_name
    'iCal URL'
  end

  def refresh_items
    client.events.each do |event|
      unless items.where(guid: event.uid).exists?
        item = items.create(
          guid: event.uid,
          title: event.summary,
          content: '',
          description: event.description,
          link: Link.where(url: service_identifier).first_or_create,
          published_at: event.dtstamp
        )
        item.tag_names = TagParser.new(event.description).parse
        #i.keywords << all_keywords
        e = item.events.build(
          start_date: event.dtstart,
          end_date: event.dtend,
          locaiton: event.location
        )
        e.location = Location.where(location: event.location).first_or_create
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
    uri = URI.parse(service_identifier)
    document ||= Net::HTTP.get(uri)
    @client ||= Icalendar.parse(document)[0]
  end

  def service_account
    return client
  end

  def get_info
    if new_record? && service_identifier_is_valid?
    #  self.name = client.title
    #  self.description = client.description
      self.url = service_identifier.sub('.ics', '.html')
    end
  end

end
