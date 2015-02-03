class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_filter :verify_authenticity_token

  def shibboleth
    @user = User.from_omniauth(request.env["omniauth.auth"])

puts 'foo'
    sign_in_and_redirect @user, :event => :authentication
    set_flash_message(:notice, :success, :kind => "Shibboleth") if is_navigational_format?
  end
end