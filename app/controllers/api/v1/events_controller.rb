class Api::V1::EventsController < Api::BaseController

  def index
    items = Item.search( *search_params(params) )
      .page(params[:page]).per(params[:per_page]).records
        .eager_load(:assets, :link, :channel, :keywords, :custom_tags)
        .from_approved.map(&:id)
    @events = Event.where(item_id: items).includes(:item)
  end

  def show
    @event = Item.includes(:items, :keywords).find(params[:id])
  end

  private 

  def search_params(params)
    [params[:search], params.except(:search)]
  end


end
