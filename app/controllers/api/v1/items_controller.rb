class Api::V1::ItemsController < ApplicationController
  respond_to :json, :xml

  def index
    @items = apply_scopes(Item)
      .from_approved
      .with_channel
      .with_all_keywords
      .page(params[:page])
      .per(params[:per_page])
  end

  def show
    @item = Item.includes(:channel, :keywords).find(params[:id])
  end

end