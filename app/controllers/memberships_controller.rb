class MembershipsController < ApplicationController

  respond_to :js

  def new
    @membership_form = MembershipForm.new(entity_id: params[:entity_id])
  end

  def create
    @membership_form = MembershipForm.new(membership_form_params)
    authorize @membership_form

    if @membership_form.save
      respond_with @membership_form
    else
      respond_to do |format|
        format.json { render :json => { :error => @membership_form.errors.full_messages }, :status => 422 }
      end
    end
  end

  def destroy
    @entity = Entity.find(params[:entity_id])
    authorize @entity
    @user = User.find(params[:user_id])
    @membership_form = MembershipForm.new(user_id: params[:user_id], entity_id: params[:entity_id])
    @membership_form.destroy
    respond_with @membership_form
  end

  private

  def membership_form_params
    params.require(:membership_form).permit(:entity_id, :user_id)
  end
end
