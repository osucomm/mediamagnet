class Api::V1::KeywordsController < Api::BaseController

  def index
    @keywords = Keyword.all
      .includes(:category)
      .page(params[:page])
      .per(params[:per_page])
  end

  def show
    @keyword = Keyword.includes(:category).find_by_name(params[:id])
  end

end
