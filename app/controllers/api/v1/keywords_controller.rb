class Api::V1::KeywordsController < Api::BaseController
  has_scope :by_category

  def index
    @keywords = apply_scopes(Keyword).all
      .includes(:category)
      .page(params[:page])
      .per(params[:per_page])
  end

  def show
    @keyword = Keyword.includes(:category).find_by_name(params[:id])
  end

end
