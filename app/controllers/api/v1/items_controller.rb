class Api::V1::ItemsController < ApplicationController
  respond_to :json, :xml

  def index
    q = params[:search]
    options = {}
    options['tag_names'] = params[:tags] if params[:tags]

    #@items = Item.search( *Item.search_params(params) )
    @items = Item.search( q, options )
      .page(params[:page]).per(params[:per_page]).records
        .eager_load(:assets, :link, :channel, :keywords)
        .from_approved

  end

  def show
    @item = Item.includes(:channel, :keywords).find(params[:id])
  end

end