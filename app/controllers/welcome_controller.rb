class WelcomeController < ApplicationController
  skip_before_filter :disallow_blocked, only: :show

  def show
    redirect_to current_user.current_entity if current_user
  end
end
