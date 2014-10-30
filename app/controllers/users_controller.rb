class UsersController < ApplicationController

  respond_to :html, :js

  def index
    @users = User.all
    authorize @users
  end

  def show
  end

  def update
    @user = User.find(params[:id])
    authorize @user

    if @user.update(user_params)
      respond_with @user do |format|
        format.html do
          flash[:success] = "User updated"
          redirect_to users_path
        end
        format.js { }
      end
    else
      respond_with @user
    end
  end

  private

  def user_params
    params.require(:user).permit(:admin, :blocked)
  end
end
