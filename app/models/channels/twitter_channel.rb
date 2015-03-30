class TwitterChannel < Channel

  def service_id_name
    'Handle'
  end

  class << self
    def icon
      'twitter'
    end
    def unicode_icon
      'f099'
    end
  end

  def refresh_items
    options = { 
      exclude_replies: true
    }

    if items.most_recent.any?
      options[:since_id] = items.most_recent.first.source_identifier
    end

    # Get tweets from our user, starting with the one after the last one we have.
    tweets = client.user_timeline(service_identifier, options)

    #Check tweet identifiers against 
    tweets.each do |tweet|
      unless items.where(source_identifier: tweet.id.to_s).exists?
        i = items.create(
          source_identifier: tweet.id,
          title: '',
          link: Link.where(url: "https://twitter.com/#{service_identifier}/status/#{tweet.id.to_s}").first_or_create,
          description: tweet.full_text,
          content: '', # Only set content for things that get special markup
          published_at: tweet.created_at,
          digest: Digest::SHA256.base64digest(tweet.full_text.to_s)
        )
        tweet.media.each do |media|
          i.assets.create(url: media.media_url_https.to_s)
        end
        i.tag_names = tweet.hashtags.map(&:text)
        i.keywords << all_keywords
        i.save
      end
    end
    log_refresh
  end

  def service_url
    "https://twitter.com/#{service_identifier}"
  end

  private

  def service_account
    begin
      client.user(service_identifier)
    rescue Twitter::Error::NotFound
      nil
    end
  end

  def client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key        = ENV['TWITTER_CONSUMER_KEY']
      config.consumer_secret     = ENV['TWITTER_CONSUMER_SECRET']
      config.access_token        = ENV['TWITTER_ACCESS_TOKEN']
      config.access_token_secret = ENV['TWITTER_ACCESS_TOKEN_SECRET']
    end
  end

  def get_info
    if new_record? && service_identifier_is_valid?
      self.name = service_account.name
      self.description = service_account.description
      self.avatar_url = service_account.profile_image_url
    end
  end

end
