class ItemsController < ApplicationController
  respond_to :html, :js, :json
  respond_to :rss, only: :index

  def index
    @items = Item
      .includes(:channel)
      .page(params[:page])
      .per(params[:per])

    @channel = Channel.find(params[:channel_id]) if params[:channel_id]
    respond_with @items
  end

  def show
    @item = Item.includes(:channel).find(params[:id])
    respond_with @items
  end
end
