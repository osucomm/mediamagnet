class Api::V1::KeywordsController < ApplicationController
  respond_to :json, :xml

  def index
    @keywords = Keyword.all.includes(:category)
  end

  def show
    @keyword = Keyword.find(params[:id])
  end

end
