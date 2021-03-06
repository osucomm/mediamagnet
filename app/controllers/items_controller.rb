class ItemsController < ApplicationController
  include Itemable
  respond_to :html

  before_action :normalize_params

  has_scope :by_channels, as: :channel_id
  has_scope :by_entities, as: :entity_id
  has_scope :by_keywords, as: :keyword_id

  def index
    search = Item.search( *search_params(params) )
        .page(params[:page]).per(params[:per_page])
    @search_response = search.response
    records = search.records
    @items = EagerPagination.new(records, :eager)

    @api_url = api_url
    @human_params = human_params
    authorize @items

    respond_with @items
  end

  def show
    @item = Item.includes(:channel, :keywords).find(params[:id])
    authorize @item
    respond_with @items
  end

  def destroy
    @item = Item.find(params[:id])
    authorize @item
    @item.destroy
    respond_with @item
  end

  private

  def normalize_params
    params[:channel_id] = params[:channel] if params[:channel]
  end

  def api_url
    p = params.dup
    api_params = Item.send(:search_facet_fields).concat(['search'])
    p.keep_if {|k,v| api_params.include?(k) && v.present? }
    url = api_v1_items_path+'.json'

    url_params = p.map do |k,v|
      if v.class == Array && v.length > 1
        v.map do |tag|
          "#{k}[]=#{tag}"
        end.join('&')
      else
        "#{k}=#{v.class == Array ? v.first : v}"
      end
    end.join('&')

    url_params.present? ? "#{url}?#{url_params}" : url
  end

  def human_params
    p = params.dup
    api_params = Item.send(:search_facet_fields).concat(['search'])
    p.keep_if {|k,v| api_params.include?(k) && v.present? }
    p.map do |k,v|
      if v.class == Array && v.length > 1
        v.map do |tag|
          "'#{tag}'"
        end.join(' or ').prepend("#{k} is ")
      else
        "#{k} is '#{v.class == Array ? v.first : v}'"
      end
    end.join(' and ')
  end

end
