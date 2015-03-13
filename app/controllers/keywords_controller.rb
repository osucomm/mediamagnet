class KeywordsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_keyword, only: [:show, :edit, :update, :destroy]
  before_action :set_categories, only: [:new, :edit]

  has_scope :by_category

  respond_to :html, :js, :json

  def index
    @keywords = apply_scopes(Keyword).normal
    respond_with @keywords
  end

  def show
    respond_with @keyword
  end

  def new
    @keyword = Keyword.new
    authorize @keyword
  end

  def create
    @keyword = Keyword.new(keyword_params)
    authorize @keyword

    if @keyword.save
      respond_with @keyword
    else
      respond_with @keyword do |format|
        format.html { render :new }
      end
    end
  end

  def edit
  end

  def update
    if @keyword.update keyword_params
      flash[:success] = "The #{@keyword.name} keyword has been updated."
      respond_with @keyword
    else
      respond_with @keyword do |format|
        format.html { render :edit }
      end
    end
  end

  def destroy
    @keyword.destroy
    flash[:success] = "The #{@keyword.name} keyword was successfully deleted."
    respond_with @keyword
  end


  private

    def keyword_params
      params.require(:keyword).permit(:name, :display_name, :description, :category_id)
    end

    def find_keyword
      @keyword = Keyword.find_by_name(params[:id])
      authorize @keyword
    end

    def set_categories
      @categories = Category.all
    end
end
