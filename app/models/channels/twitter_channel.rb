class TwitterChannel < Channel
  def service_id_name
    'Handle'
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

    # Get tweets from our user, starting with the one after the last one we have.
    tweets = client.user_timeline(name, since_id: items.most_recent.guid)

    #Check tweet identifiers against 
    tweets.each do |tweet|
      unless items.where(guid: tweet.id.to_s).exists?
        items.create(
          guid: tweet.id,
          description: tweet.text,
          published_at: tweet.created_at
        )
      end
    end
    true
    super
  end

  def link_for(item)
    "https://twitter.com/#{service_identifier}/status/#{item.guid}"
  end

end
