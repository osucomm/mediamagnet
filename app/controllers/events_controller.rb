class EventsController < ApplicationController
  include Syndicatable
  respond_to :html

  before_action :normalize_params


  has_scope :after, default: Time.now.to_s do |controller, scope, value|
    scope.after(Time.parse(value))
  end
  has_scope :before do |controller, scope, value|
    scope.before(Time.parse(value))
  end

  def index
    # Paging only works with one-to-one correspondance of items to events!
    items = Item.search( *search_params(params) ).page(1).per(1000000)
      .records
        .pluck(:id)

    @events = apply_scopes(Event)
      .where(item_id: items)
      .includes(:location, item: [:keywords, :custom_tags, :links, :link, :assets, :channel])
      .page(params[:page]).per(params[:per_page])
      .ordered
    authorize @events

    respond_with @events
  end

  def show
    @event = Event.includes(:item, :location).find(params[:id])
    authorize @event
    respond_with @event
  end

  private 

  def search_params(params)
    [params[:search], params.except(:search).merge(events_only: true)]
  end

end
