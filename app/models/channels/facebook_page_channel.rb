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
          title: post['message'],
          description: post['message'],
          link: "https://www.facebook.com/#{service_identifier}/posts/#{post['id'].split('_').last}",
          published_at: post['created_time']
        )
        i.assets.build(url: post['picture']) if post['picture']
        i.tag_names = TagParser.new(i.title).parse
      end
    end
    true
    super
  end

  private

  def client
    @graph ||= Koala::Facebook::API.new(token.access_token)
  end

  def token
    Token.where(provider: :facebook).first
  end

end
