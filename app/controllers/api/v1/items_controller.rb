class Api::V1::ItemsController < ApplicationController
  respond_to :json, :xml

  def index
    @items = Item.search( *Item.search_params(params) )
      .page(params[:page]).per(params[:per_page]).records
        .eager_load(:assets, :link, :channel, :keywords)
        .from_approved

  end

  def show
    @item = Item.includes(:channel, :keywords).find(params[:id])
  end

end