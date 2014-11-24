class DashboardController < ApplicationController
  before_action :authenticate_user!

  def show
    path = current_user.current_entity || entities_path
    redirect_to path
  end
end
