class LinksController < ApplicationController
  def index
    @links = Link.all.page(params[:page]).per(params[:per_page])
    authorize @links
  end
end
