class Api::V1::EntitiesController < Api::BaseController

  def index
    @entities = Entity.all.includes(:keywords)
  end

  def show
    @entity = Entity
      .includes(:channels, :keywords, :mappings, :mapped_tags, :mapped_keywords, :contact)
      .find(params[:id])
  end

end
