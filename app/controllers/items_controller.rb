class ItemsController < ApplicationController
  respond_to :html, :js, :json
  respond_to :rss, only: :index

  before_action :normalize_params

  has_scope :by_channels, as: :channel_id
  has_scope :by_entities, as: :entity_id
  has_scope :by_keywords, as: :keyword_id

  def index
    search = Item.search( *search_params(params) )
    @search_response = search.response
    @items = search.page(params[:page]).per(params[:per_page]).records
        .eager_load(:assets, :link, :channel, :keywords)
        .from_approved
        .page(params[:page]).per(params[:per_page])

    @api_url = api_url
    authorize @items


    respond_with @items
  end

  def show
    @item = Item.includes(:channel, :keywords).find(params[:id])
    authorize @item
    respond_with @items
  end


  private

  def normalize_params
    params[:channel_id] = params[:channel] if params[:channel]
  end

  def search_params(params)
    [params[:search], params.except(:search)]
  end

  def api_url
    p = params.dup
    api_params = Item.send(:search_facet_fields).concat(['search'])
    p.keep_if {|k| api_params.include?(k) }
    url = "/api/v1/items.json?"
    url += p.map do |k,v|
      if v.class == Array && v.length > 1
        a = ''
        v.each do |tag|
          a = "#{k}[]=#{tag}"
        end.join('&')
      else
        a = "#{k}=#{v.first}"
      end
      a
    end.join('&')
  end

end
