class FundChannel < Channel
  class << self
    def type_name
      'Funds'
    end

    def icon
      'bookmark'
    end
    def unicode_icon
      'f02e'
    end
  end

  def service_id_name
    'Feed Feed'
  end

  def refresh_items
    delete_inactive_funds

    client.each do |fund|
      if fund_record = items.where(source_identifier: fund['source_identifier']).first
        if Digest::SHA256.base64digest(fund.to_s) != fund_record.digest
          # Update fund
          fund_record.title = fund['title']
          fund_record.description = fund['description']
          fund_record.digest = Digest::SHA256.base64digest(fund.to_s)
          fund_record.tag_names = fund['tags']
          fund_record.save
          fund_record.update_es_record
          logger.info {"Fund #{fund_record.source_identifier} updated at #{Time.now}."}
        end
      else
        # Create fund
        i = items.build(
          source_identifier: fund['source_identifier'],
          title: fund['title'],
          link: Link.where(url: fund['url']).first_or_create,
          description: fund['description'],
          digest: Digest::SHA256.base64digest(fund.to_s)
        )
        i.tag_names = fund['tags']
        i.keywords << all_keywords
        i.update_es_record
      end
    end
    log_refresh
  end

  def delete_inactive_funds
    active_fund_ids = client.map do |fund|
      fund['source_identifier']
    end

    # Quick sanity check before we delete funds that our feed isn't borked.
    if active_fund_ids.length > 5000
      items.where('source_identifier not in (?)', active_fund_ids).each do |item|
        item.destroy
        logger.info {"Fund #{item.source_identifier} deleted at #{Time.now}."}
      end
    end
  end

  def service_identifier_validator
    unless service_identifier_is_valid?
      errors.add :service_identifier, " must be a valid funds channel"
    end
  end

  def service_url
    "http://www.osu.edu/giving/"
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
