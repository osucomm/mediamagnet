class WelcomeController < ApplicationController
  skip_before_filter :disallow_blocked, only: :show

  def show
    path = current_user.current_entity || entities_path
    redirect_to path if current_user
  end
end
