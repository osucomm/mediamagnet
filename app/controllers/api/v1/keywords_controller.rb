class Api::V1::KeywordsController < Api::BaseController

  def index
    @keywords = Keyword.all.includes(:category)
  end

  def show
    @keyword = Keyword.find(params[:id])
  end

end
