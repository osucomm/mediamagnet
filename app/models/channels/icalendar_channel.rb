class IcalendarChannel < Channel
  class << self
    def type_name
      'icalendar'
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
      unless items.where(guid: event.uid.to_s).exists?
        item = items.create(
          guid: event.uid.to_s,
          title: event.summary.to_s,
          content: '',
          description: event.description.to_s,
          published_at: event.dtstamp
        )
        item.tag_names = TagParser.new(event.description.to_s).parse
        #i.keywords << all_keywords
        starts_at = event.dtstart
        ends_at = event.dtend
        if ((client.prodid =~ /Microsoft Exchange/) == 0)
          starts_at = ExchangeTimeParser.new(event.dtstart).parse
          ends_at = ExchangeTimeParser.new(event.dtend).parse
        end
        e = item.events.build(
          start_date: starts_at,
          end_date: ends_at
        )
        e.location = Location.where(location: event.location.to_s).first_or_create
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
    @client
  end

  def service_account
    return client
  end

  def get_info
    if new_record? && service_identifier_is_valid?
      self.name = 'My Calendar' # client.title
    #  self.description = client.description
      self.url = service_identifier.sub('.ics', '.html')
    end
  end

end
