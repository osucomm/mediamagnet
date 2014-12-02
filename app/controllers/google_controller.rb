class GoogleController < ApplicationController
  def choose

  end

  def auth
    redirect_to google_client.authorization_uri.to_s
  end

  def callback
    if params[:code]
      google_client.code = params[:code]
      google_client.fetch_access_token!
      @token = Token.create(
        access_token: google_client.access_token,
        refresh_token: google_client.refresh_token,
        expires_at: google_client.expires_in.to_i.seconds.from_now.to_datetime)
      session[:token_id] = @token.id
      redirect_to new_entity_youtube_playlist_channel_path(
        entity_id: current_user.current_entity_id,
      )
    end
  end

  private

  def google_client
    @google_client ||= GoogleClient.new.client
  end

end
