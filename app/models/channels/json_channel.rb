class JsonChannel < Channel
  class << self
    def type_name
      'JSON Items'
    end

    def icon
      'file'
    end
    def unicode_icon
      'f15b'
    end
  end

  def service_id_name
    'Json Feed URL'
  end

  def refresh_items
    client.each do |record|
      item = {
        title: record['title'].to_s.strip,
        description: record['description'].to_s.strip,
        source_identifier: record['source_identifier'].to_s.strip,
        digest: Digest::SHA256.base64digest(record.to_s),
        link: record['url'].to_s.strip,
        tag_names: record['tags'],
        asset_urls: []
      }
      if record.has_key?('start_date')
        item[:events] = [{
          start_date: record['start_date'].to_s,
          end_date: record['end_date'].to_s,
          location: record['location'].to_s
        }]
      end
      ItemFactory.create_or_update_from_hash(item, self)
    end
    log_refresh
  end

  def service_identifier_validator
    unless service_identifier_is_valid?
      errors.add :service_identifier, " must be a valid #{type_name} channel"
    end
  end

  private

  def client
    @client ||= (
      uri = URI(service_identifier)
      response = Net::HTTP.get(uri)
      JSON.parse(response)['data']
    )
  end

  def service_account
    client
  end

end
