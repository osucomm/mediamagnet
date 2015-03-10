class Api::V1::ChannelsController < Api::BaseController

  def index
    @channels = Channel.all
      .includes(:keywords)
      .page(params[:page])
      .per(params[:per_page])
  end

  def show
    @channel = Channel
      .includes(:keywords, :entity, :mappings, :contact, :mapped_tags, :mapped_keywords)
      .find(params[:id])
  end

end
