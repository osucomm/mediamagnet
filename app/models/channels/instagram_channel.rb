class InstagramChannel < Channel

  before_save :set_service_identifier_id

  validate :is_instagram_user

  def service_id_name
    'Account name'
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


  def refresh_items
    @new_count = 0

    # Get tweets from our user, starting with the one after the last one we have.
    # media = client.user_timeline(name, since_id: items.most_recent.first.guid)

    #Check tweet identifiers against 
    #tweets.each do |tweet|
    #  unless items.where(guid: tweet.id.to_s).exists?
    #    items.create(
    #      guid: tweet.id,
    #      description: tweet.text,
    #      published_at: tweet.created_at
    #    )
    #  end
    #end
    #true
    #super
  end

  def link_for(item)
    "https://twitter.com/#{service_identifier}/status/#{item.guid}"
  end

  private

  def set_service_identifier_id
    service_identifer_id = matching_users.first.id
  end

  def is_instagram_user
    if matching_users.count == 1
      matching_users.first.id
    else
      errors.add :service_identifier, ' must match current instagram account'
    end
  end

  def matching_users
    client.user_search(service_identifier).select do |instagram_user|
      instagram_user.username == service_identifier
    end
  end


end
