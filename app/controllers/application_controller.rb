class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  include Pundit
  protect_from_forgery with: :exception
  before_filter :disallow_blocked

  private

  def disallow_blocked
    if current_user && current_user.blocked?
      flash[:danger] = "You have been logged out because account has been blocked."
      sign_out(current_user)
      redirect_to root_path
    end
    return true
  end
end
