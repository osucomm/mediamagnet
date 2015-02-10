class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
  before_filter :disallow_blocked

  helper_method :current_user, :user_signed_in?


  private

  def redirect_or_respond_with(model)
    if flash[:action_redirect]
      redirect_to flash[:action_redirect]
    else
      respond_with model
    end
  end

  def after_action_redirect_to(location)
    flash[:action_redirect] = location
  end

  def preserve_action_redirect!
    flash.keep :action_redirect
  end


  def disallow_blocked
    if current_user && current_user.blocked?
      self.current_user = nil
      redirect_to root_path, danger: "You have been logged out because your account has been blocked."
    end
    return true
  end

  def authenticate_user!
    unless user_signed_in?
      session[:return_to] = request.fullpath
      redirect_to auth_path(:shibboleth)
    end
  end


  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
  end

  def user_signed_in?
    !!current_user
  end

  def current_user=(user)
    @current_user = user
    session[:user_id] = user.nil? ? nil : user.id
  end
end
