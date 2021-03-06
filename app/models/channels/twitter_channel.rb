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

    # Get tweets from our user, starting with the one after the last one we have.
    tweets = client.user_timeline(service_identifier, options)

    #Check tweet identifiers against 
    tweets.each do |tweet|
      item = {
        source_identifier: tweet.id,
        title: '',
        link: "https://twitter.com/#{service_identifier}/status/#{tweet.id.to_s}",
        description: tweet.full_text,
        content: '', # Only set content for things that get special markup
        published_at: tweet.created_at,
        digest: Digest::SHA256.base64digest(tweet.full_text.to_s),
        asset_urls: tweet.media.map {|m| m.media_url_https.to_s},
        tag_names: tweet.hashtags.map(&:text)
      }
      ItemFactory.create_or_update_from_hash(item, self)
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
    if service_identifier_is_valid?
      self.name = service_account.name
      self.description = service_account.description
      self.avatar_url = service_account.profile_image_url
    end
  end

end
