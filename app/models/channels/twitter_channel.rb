class TwitterChannel < Channel

  def service_id_name
    'Handle'
  end

  class << self
    def icon
      'twitter'
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

  def refresh_items
    @new_count = 0

    options = {}

    if items.most_recent.any?
      options[:since_id] = items.most_recent.first.guid
    end

    # Get tweets from our user, starting with the one after the last one we have.
    tweets = client.user_timeline(name, options)

    #Check tweet identifiers against 
    tweets.each do |tweet|
      unless items.where(guid: tweet.id.to_s).exists?
        i = items.build(
          guid: tweet.id,
          description: tweet.text,
          published_at: tweet.created_at
        )
        i.tag_names = tweet.hashtags.map(&:text)
      end
    end
    true
    super
  end

  def link_for(item)
    "https://twitter.com/#{service_identifier}/status/#{item.guid}"
  end

end
