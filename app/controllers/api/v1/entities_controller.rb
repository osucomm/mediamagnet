class Api::V1::EntitiesController < Api::BaseController

  def index
    @entities = Entity.all.includes(:channels)
  end

  def show
    @entity = Entity.find(params[:id])
  end

end
