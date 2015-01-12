class FacebookPageChannel < Channel
  def service_id_name
    'Page name'
  end

  def icon
    'facebook'
  end

  def posts
    client.get_object("#{service_identifier}/posts")
  end

  def refresh_items
    posts.each do |post|
      unless items.where(guid: post['id']).exists?
        i = items.build(
          guid: post['id'],
          title: truncate(post['message'], 255),
          description: post['message'],
          link: Link.where(url: "https://www.facebook.com/#{service_identifier}/posts/#{post['id'].split('_').last}").first_or_create,
          published_at: post['created_time']
        )
        i.assets.build(url: post['picture']) if post['picture']
        i.tag_names = TagParser.new(i.title).parse
      end
    end
    log_refresh
  end
  handle_asynchronously :refresh_items

  private

  def client
    @graph ||= Koala::Facebook::API.new(token.access_token)
  end

  def service_account
    begin
      client.get_object(service_identifier)
    rescue Koala::Facebook::ClientError
      nil
    end
  end

  def get_info
    if new_record? && service_account
      self.name = service_account['name']
      self.description = service_account['description']
      self.url = service_account['link']
    end
  end

  def token
    Token.where(provider: :facebook).last
  end

end
