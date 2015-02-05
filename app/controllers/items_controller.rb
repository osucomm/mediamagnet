class ItemsController < ApplicationController
  respond_to :html, :js, :json
  respond_to :rss, only: :index

  before_action :normalize_params

  has_scope :by_channels, as: :channel_id
  has_scope :by_keywords, as: :keyword_id

  def index
    @channel = Channel.find(params[:channel_id]) if params[:channel_id]
    @current_keyword = Keyword.find(params[:keyword_id]) if params[:keyword_id]
    @items = apply_scopes(Item)
      .from_approved
      .with_channel
      .with_all_keywords
      .page(params[:page])
      .per(params[:per_page])

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
end
