class Api::V1::EventsController < Api::BaseController
  include Syndicatable

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
        .map(&:id)
    @events = apply_scopes(Event)
      .where(item_id: items)
      .includes(:location, item: [:keywords, :custom_tags, :links, :link, :assets, :channel])
      .page(params[:page]).per(params[:per_page])
      .ordered
  end

  def show
    @event = Event.includes(:item, :location).find(params[:id])
  end

  private 

  def search_params(params)
    [params[:search], params.except(:search).merge(events_only: true)]
  end

end
