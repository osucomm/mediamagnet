class WelcomeController < ApplicationController
  skip_before_filter :disallow_blocked, only: :show

  def show
    redirect_to dashboard_path if user_signed_in?
  end
end
