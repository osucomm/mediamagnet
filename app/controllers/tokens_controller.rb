class TokensController < ApplicationController
  def index
    @tokens = Token.all
  end

  def create
    @token = Token.create_from_omniauth_hash(auth_hash)
    authorize @token
    # TODO: make this redirect to new form in correct cases to replace
    # google controller.
  end
  
  def destroy
    @token = Token.find(params[:id])
    authorize @token
    @token.destroy
    redirect_to takens_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
