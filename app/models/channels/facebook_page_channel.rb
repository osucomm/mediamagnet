class FacebookPageChannel < Channel
  def service_id_name
    'Page name'
  end

  def icon
    'facebook'
  end

  def posts
    client.get_object("#{service_identifier}/posts").keep_if do |post|
      post.key? 'message'
    end
  end

  def refresh_items
    posts.each do |post|
      unless items.where(source_identifier: post['id']).exists?
        i = items.build(
          source_identifier: post['id'],
          title: '',
          description: post['message'],
          content: '',
          link: Link.where(url: "https://www.facebook.com/#{service_identifier}/posts/#{post['id'].split('_').last}").first_or_create,
          published_at: post['created_time'],
          digest: Digest::SHA256.base64digest(post['message'])
        )
        i.assets.build(url: post['picture']) if post['picture']
        i.tag_names = TagParser.new(i.title).parse
        i.keywords << all_keywords
        i.update_es_record
      end
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
