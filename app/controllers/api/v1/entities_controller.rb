class Api::V1::EntitiesController < ApplicationController
  respond_to :json, :xml

  def index
    @entities = Entity.all.includes(:channels)
  end

  def show
    @entity = Entity.find(params[:id])
  end

end
