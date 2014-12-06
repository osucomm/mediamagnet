class TokensController < ApplicationController
  def create
    @token = Token.create(
      provider: auth_hash.provider,
      access_token: auth_hash.credentials.token,
      refresh_token: auth_hash.credentials.refresh_token,
      expires_at: DateTime.strptime(auth_hash.credentials.expires_at.to_s, '%s')
    )
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
