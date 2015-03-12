class Api::V1::ItemsController < Api::BaseController
  include Itemable
  respond_to :rss, only: :index

  def index
    # If the request is RSS and for a single channel, grab the channel model
    if request.format.rss? and params.key?(:channel_id)
      @channel = Channel.find(params[:channel_id]) unless params[:channel_id].is_a? Array
    end

    search = Item.search( *search_params(params) ).page(params[:page]).per(params[:per_page])
    records = search.records
    @items = EagerPagination.new(records, :eager)
  end

  def show
    @item = Item.includes(:channel, :keywords, :custom_tags, :events, :links).find(params[:id])
  end

end
