class Api::V1::ItemsController < Api::BaseController
  include Itemable
  include Syndicatable

  def index
    search = Item.search( *search_params(params) ).page(params[:page]).per(params[:per_page])
    records = search.records
    @items = EagerPagination.new(records, :eager)
  end

  def show
    @item = Item.includes(:channel, :keywords, :custom_tags, :events, :links).find(params[:id])
  end

end
