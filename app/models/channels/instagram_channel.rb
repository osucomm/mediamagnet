class InstagramChannel < Channel

  # Callbacks
  # Instagram endpoint queries are based on numeric user id, so lets set that.
  before_save :set_service_identifier_id

  # Validations
  validate :is_instagram_user

  def service_id_name
    'Account name'
  end

  def icon
    'instagram'
  end

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
    if new_record? && instagram_user
      self.name = instagram_user.full_name
      self.description = instagram_user.bio
    end
  end

  def refresh_items
    new_media.each do |media|
      unless items.where(guid: media.id.to_s).exists?
        i = items.build(
          guid: media.id,
          title: (media.caption? ? media.caption.text : 
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

  def set_service_identifier_id
    self.service_identifier_id = instagram_user.id unless service_identifier.nil?
  end

  def is_instagram_user
    unless instagram_user
      errors.add :service_identifier, ' must match current instagram account'
    end
  end

  def instagram_user
    @user ||=
      client.user_search(service_identifier).select do |instagram_user|
        instagram_user.username == service_identifier
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

  private

  def set_keywords
    photo = Keyword.where(name: 'photo').first
    if photo
      keywords << photo unless keywords.include?(photo)
    end
  end


end
