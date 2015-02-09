class Admin::EntitiesController < Admin::BaseController
  before_action :authenticate_user!
  respond_to :html, :js

  def index
    @entities = Entity.not_approved.page(params[:page])
    authorize @entities, :approve?
    after_action_redirect_to admin_entities_path
  end

  def update
    @entity = Entity.find(params[:id])
    authorize @entity, :approve?

    if @entity.update(entity_params)
      respond_with @entity do |format|
        format.html do
          flash[:success] = "#{@entity.name} was approved"
          redirect_to admin_entities_path
        end
      end
    else
      respond_with @entity
    end
  end


  private

    def entity_params
      params.require(:entity).permit(:approved)
    end
end