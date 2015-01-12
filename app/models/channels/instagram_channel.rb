class InstagramChannel < Channel

  # Callbacks
  # Instagram endpoint queries are based on numeric user id, so lets set that.
  # before_save :set_service_identifier_id

  def service_id_name
    'Account name'
  end

  def icon
    'instagram'
  end

  def initial_keywords
    %w(photo)
  end

  def refresh_items
    new_media.each do |media|
      unless items.where(guid: media.id.to_s).exists?
        i = items.build(
          guid: media.id,
          title: (media.caption? ? truncate(media.caption.text, 250) : 
            "Instagram from @#{service_identifier} on #{Date.strptime(media.created_time, '%s')}"),
          link: Link.where(url: media.link).first,
          description: (media.caption? ? media.caption.text : ''),
          published_at: Date.strptime(media.created_time, '%s')
        )
        i.assets.build(url: media.images.standard_resolution.url)
        i.tag_names = media.tags
      end
    end
    log_refresh
  end
  handle_asynchronously :refresh_items

  private

  def client
    @client ||=
      begin
        Instagram.configure do |config|
          config.client_id       = ENV['INSTAGRAM_CLIENT_ID']
          config.client_secret   = ENV['INSTAGRAM_CLIENT_SECRET']
        end
        Instagram.client
      end
  end

  def new_media
    client.user_recent_media(service_identifier_id,
                             min_id: (most_recent_item_id.to_i + 1))
  end

  def get_info
    if new_record? && service_identifier_is_valid?
      self.name = service_account.full_name
      self.description = service_account.bio
      self.service_identifier_id = service_account.id 
    end
  end

  def service_account
    @user ||=
      client.user_search(service_identifier).select do |service_account|
        service_account.username == service_identifier
      end.first
  end

  def most_recent_item_id
    # Although api service [media_id]_[user_id] format, it expects queries
    # based off of just [media_id].
    if items.most_recent.any? 
      items.most_recent.first.guid.split('_').first
    else
      0
    end
  end

end
