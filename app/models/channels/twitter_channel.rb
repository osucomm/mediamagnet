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

  def run
    new_count = 0

    # Get tweets from our user.
    tweets = client.user_timeline(name)

    #Check tweet identifiers against 
    tweets.each do |tweet|
      unless items.where(guid: tweet.id).exists?
        items.create(
          guid: tweet.id,
          description: tweet.text,
          published_at: created_at
        )
      end
    end
    logger.info "Channel #{name} updated with #{new_count} new items."
  end

end
