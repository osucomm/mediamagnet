class FundChannel < Channel
  class << self
    def type_name
      'Funds'
    end
  end

  def service_id_name
    'Feed Feed'
  end

  def icon
    'rss'
  end

  def refresh_items

    client.each do |fund|
      if fund_record = items.where(source_identifier: fund['source_identifier']).first
        if Digest::SHA256.base64digest(fund.to_s) != fund_record.digest
          # Update fund
        end
      else
        # Create fund
        i = items.build(
          source_identifier: fund['source_identifier'],
          guid: fund['guid'],
          title: fund['title'],
          link: Link.where(url: fund['url']).first_or_create,
          description: fund['description'],
          digest: Digest::SHA256.base64digest(fund.to_s)
        )
        i.tag_names = fund['tags'].split(',')
        i.keywords << all_keywords
      end
    end
    log_refresh
  end
  handle_asynchronously :refresh_items

  def service_identifier_validator
    unless service_identifier_is_valid?
      errors.add :service_identifier, " must be a valid funds channel"
    end
  end

  private

  def client
    @client ||= (
      uri = URI(service_identifier)
      response = Net::HTTP.get(uri)
      JSON.parse(response)
    )
  end

  def service_account
    client
  end

  def get_info
  end

end
