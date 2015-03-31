class FacebookPageChannel < Channel

  class << self
    def icon
      'facebook'
    end
    def unicode_icon
      'f09a'
    end
  end

  def service_id_name
    'Page name'
  end

  def posts
    client.get_object("#{service_identifier}/posts").select do |post|
      post.key? 'message'
    end
  end

  def refresh_items
    posts.each do |post|
      item = {
        source_identifier: post['id'],
        title: '',
        description: post['message'],
        content: '',
        link: "https://www.facebook.com/#{service_identifier}/posts/#{post['id'].split('_').last}",
        published_at: post['created_time'],
        digest: Digest::SHA256.base64digest(post['message']),
        asset_urls: ([post['picture']] if post['picture']),
        tag_names: TagParser.new(post['message']).parse
      }
      ItemFactory.create_or_update_from_hash(item, self)
    end
    log_refresh
  end

  def service_url
    "https://www.facebook.com/#{service_identifier}"
  end

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
      self.avatar_url = client.get_picture(service_identifier)
    end
  end

  def token
    Token.where(provider: :facebook).last
  end

end
