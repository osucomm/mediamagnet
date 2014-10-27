class EntitiesController < ApplicationController

  before_action :authenticate_user!

  respond_to :html, :js

  def index
  end

  def show
  end

  def new
    @entity = Entity.new
    authorize @entity
  end

  def create
    @entity = Entity.new(entity_params)
    authorize @entity

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
  end

  private

  def entity_params
    params.require(:entity).permit(:name, :description, :link)
  end
end
