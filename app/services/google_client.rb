class GoogleClient

  def client(options = {})
    new_options = {
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      authorization_endpoint_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_endpoint_uri: 'https://accounts.google.com/o/oauth2/token',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      token_uri: 'https://accounts.google.com/o/oauth2/token',
      redirect_uri: 'http://17f46ae8.ngrok.com/auth/google/callback',
      client_id: ENV['GOOGLE_CLIENT_ID'],
      client_secret: ENV['GOOGLE_CLIENT_SECRET'],
      scope: 'https://www.googleapis.com/auth/youtube.readonly',
      access_type: 'offline'
    }.merge(options)
    Signet::OAuth2::Client.new(new_options)
  end

end
