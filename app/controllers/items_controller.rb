class ItemsController < ApplicationController
  def index
    @items = Item
      .includes(:channel)
      .page(params[:page])
      .per(params[:per])
  end

  def show
  end
end
