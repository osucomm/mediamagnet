class KeywordsController < ApplicationController
  respond_to :html, :js, :json, :xml

  def index
    @keywords = Keyword.all
    respond_with @keywords
  end

  def show
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
