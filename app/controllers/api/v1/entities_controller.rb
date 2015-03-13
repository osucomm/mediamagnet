class Api::V1::EntitiesController < Api::BaseController

  def index
    @entities = Entity.unscoped.all.approved
      .includes(:keywords)
      .page(params[:page])
      .per(params[:per_page])
  end

  def show
    @entity = Entity
      .includes(:channels, :keywords, :mappings, :mapped_tags, :mapped_keywords, :contact)
      .find(params[:id])
  end

end
