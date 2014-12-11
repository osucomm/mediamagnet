class GoogleController < ApplicationController

  def choose
  end

  def callback
    @token = Token.create_from_omniauth_hash(auth_hash)
    session[:token_id] = @token.id
    redirect_to new_entity_youtube_playlist_channel_path(
      entity_id: current_user.current_entity_id,
      name: auth_hash['info']['name']
    )
  end

  private

  def google_client
    @google_client ||= GoogleClient.new.client
  end

  def auth_hash
    request.env['omniauth.auth']
  end

end
