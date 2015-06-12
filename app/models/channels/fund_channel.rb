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
      item = {
        title: fund['title'],
        description: fund['description'],
        source_identifier: fund['source_identifier'],
        digest: Digest::SHA256.base64digest(fund.to_s),
        link: fund['url'],
        tag_names: fund['tags'],
        asset_urls: []
      }
      ItemFactory.create_or_update_from_hash(item, self)
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
      begin
        response = Net::HTTP.get(uri)
      rescue Net::ReadTimeout
        logger.warn "Could not connect to channel #{self.to_s}"
        exit
      end
      JSON.parse(response)
    )
  end

  def service_account
    client
  end

  def get_info
  end

end
