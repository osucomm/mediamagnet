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
    existing_identifiers = items.map(&:source_identifier)
    client.entries.each do |wi|
      #Only do work if this item was modified since we last polled, or if there is no last modified, or if we don't have the item.
      source_identifier = [wi.entry_id, wi.url].find(&:present?).to_s.strip
      if wi.modified.nil? || 
          Time.parse(wi.modified) > last_polled_at ||
          !existing_identifiers.include?(source_identifier)
        item = {
          content: wi.content,
          description: wi.summary.to_s.strip,
          digest: Digest::SHA256.base64digest(%w(title content summary start_date end_date location categories)
            .map {|el| wi[el.to_s].to_s}.reduce(:+)),
          published_at: wi.published.present? ? wi.published : Time.now,
          source_identifier: source_identifier,
          title: wi.title.to_s.strip,
          link: [wi.url, wi.entry_id].find(&:present?),
          asset_urls: [:image, :enclosure_url].map {|element| wi.try(element)}.reject(&:nil?),
          tag_names: (wi.categories if wi.respond_to?(:categories))
        }
        if wi.start_date.present?
          item[:events] = [{
            start_date: (wi.start_date if wi.respond_to?(:start_date)).to_s,
            end_date: (wi.end_date if wi.respond_to?(:end_date)).to_s,
            location: (wi.location if wi.respond_to?(:location)).to_s
          }]
        end
        ItemFactory.create_or_update_from_hash(item, self)
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
    read_attribute(:url) || service_identifier
  end

  private

  def client
    @client ||= (
        f = Feedjira::Feed
        f.add_common_feed_entry_element('dc:modified', as: :modified)
        f.add_common_feed_entry_elements('dc:subject', as: :categories)
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
    if service_identifier_is_valid?
      self.name = client.title
      self.description = client.description
      self.url = client.feed_url
    end
  end

end
