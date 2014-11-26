class GoogleController < ApplicationController
  def auth
    redirect_to user_credentials.authorization_uri.to_s
  end

  def callback
    if params[:code]
      user_credentials.code = params[:code] if params[:code]
      user_credentials.fetch_access_token!
    end
  end

  private

  def user_credentials
    @authorization ||= (
      auth = client.authorization.dup
      auth.redirect_uri = "https://#{request.host}/google/oauth2callback"
      options = {}
      auth.update_token!(options)
      options.each do |k,v|
        session[k] = v
      end
      auth
    )
  end

  def client
    # Initialize the client.
    @google_client ||= begin
      client = Google::APIClient.new(
        application_name: 'Media Magnet',
        application_version: '0.1'
      )
      client_secrets = Google::APIClient::ClientSecrets.load
      client.authorization = client_secrets.to_authorization
      client.authorization.scope = 'https://www.googleapis.com/auth/youtube.readonly'
      client
    end
  end



end
