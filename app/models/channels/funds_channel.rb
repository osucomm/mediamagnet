class FundsChannel < Channel
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
    funds = client['items']

    funds.each do |fund|
      if items.where(source_identifier: fund.source_identifier).exists?
        # Update fund
      else
        # Create fund
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
