class InstagramChannel < Channel
  #

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
      unless items.where(source_identifier: media.id.to_s).exists?
        i = items.build(
          source_identifier: media.id.to_s,
          title: '',
          description: (media.caption? ? media.caption.text : ''),
          content: '',
          link: Link.where(url: media.link).first_or_initialize,
          published_at: Time.strptime(media.created_time, '%s'),
          digest: Digest::SHA256.base64digest(media.to_s)
        )
        if media.respond_to?(:images)
          i.assets.build(url: media.images.standard_resolution.url)
        end
        if media.respond_to?(:videos)
          i.assets.build(url: media.videos.standard_resolution.url)
          i.keywords << Keyword.find_by_name('video')
        end
        i.tag_names = media.tags
        i.keywords << all_keywords
        i.update_es_record
      end
    end
    log_refresh
  end

  def html_content_for(item)
    "<img src=\"#{item.assets.first.url}\">"
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

  def new_media
    client.user_recent_media(service_identifier_id,
                             min_id: (most_recent_item_id.to_i + 1))
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
