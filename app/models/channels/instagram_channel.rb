class InstagramChannel < Channel

  class << self
    def icon
      'instagram'
    end
    def unicode_icon
      'f16d'
    end
  end

  def service_id_name
    'Account name'
  end

  def initial_keywords
    %w(photo)
  end

  def refresh_items
    recent_media.each do |media|
      item = {
        source_identifier: media.id.to_s,
        title: '',
        description: (media.caption? ? media.caption.text : ''),
        content: '',
        link: media.link,
        published_at: Time.strptime(media.created_time, '%s'),
        digest: Digest::SHA256.base64digest(media.to_s),
        tag_names: media.tags,
        asset_urls: [
          media.images ? media.images.standard_resolution.url : nil, 
          media.videos ? media.videos.standard_resolution.url : nil
        ].compact
      }
      ItemFactory.create_or_update_from_hash(item, self)
    end
    log_refresh
  end

  def service_url
    "https://instagram.com/#{service_identifier}"
  end

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

  def recent_media
    client.user_recent_media(service_identifier_id)
  end

  def get_info
    if new_record? && service_identifier_is_valid?
      self.name = service_account.full_name
      self.description = service_account.bio
      self.service_identifier_id = service_account.id 
      self.avatar_url = service_account.profile_picture
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
