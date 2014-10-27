class EntitiesController < ApplicationController

  before_action :authenticate_user!

  respond_to :html, :js

  def index
    @entities = Entity.all
    authorize @entities
  end

  def show
    @entity = Entity.includes(:channels, :users).find(params[:id])
  end

  def new
    @entity = Entity.new
    authorize @entity
  end

  def create
    @entity = Entity.new(entity_params)
    authorize @entity

    @entity.users << current_user

    if @entity.save
      respond_with @entity
    else
      response_with @entity do |format|
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
    @entity = Entity.find(params[:id])
    authorize @entity

    if @entity.destroy
      flash[:success] = "Entity #{@entity.name} destroyed."
      redirect_to entities_path
    else
      flash[:error] = "Entity #{@entity.name} could not be destroyed."
      redirect_to entities_path
    end
  end

  private

  def entity_params
    params.require(:entity).permit(:name, :description, :link)
  end
end
