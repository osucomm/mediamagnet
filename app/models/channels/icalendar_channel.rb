class IcalendarChannel < Channel
  class << self
    def type_name
      'iCal'
    end

    def icon
      'calendar'
    end
    def unicode_icon
      'f073'
    end
  end

  def service_id_name
    'iCal URL'
  end

  def refresh_items
    client.events.each do |event|
        binding.pry
      item = {
        source_identifier: event.uid.to_s,
        title: event.summary.to_s,
        content: '',
        description: event.description.to_s,
        published_at: event.dtstamp,
        asset_urls: [],
        digest: Digest::SHA256.base64digest(event.summary.to_s + event.description.to_s + event.dtstart.to_s + event.dtend.to_s + event.location.to_s),
        tag_names: TagParser.new(event.description.to_s).parse,
        events: [{
          start_date: ((client.prodid =~ /Microsoft Exchange/) == 0) ? ExchangeTimeParser.new(event.dtstart).parse : event.dtstart,
          end_date: ((client.prodid =~ /Microsoft Exchange/) == 0) ? ExchangeTimeParser.new(event.dtend).parse : event.dtend,
          location: event.location.to_s
        }]
      }
      ItemFactory.create_or_update_from_hash(item, self)
    end
    log_refresh
  end

  def service_identifier_validator
    unless service_identifier_is_valid?
      errors.add :service_identifier, " must be a valid iCalender file (usually with a '.ics' extension).".html_safe
    end
  end

  private

  def client
    self.service_identifier = Link.resolve_uri(service_identifier)
    if Link.is_uri?(service_identifier)
      uri = URI.parse(service_identifier)
      document ||= Net::HTTP.get(uri)
      @client ||= Icalendar.parse(document)[0]
      @client
    end
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
