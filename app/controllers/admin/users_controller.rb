class Admin::UsersController < Admin::BaseController

  respond_to :html, :js

  def index
    @users = User.page(params[:page])
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
          redirect_to admin_users_path
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
