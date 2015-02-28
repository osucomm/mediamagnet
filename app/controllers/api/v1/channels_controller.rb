class Api::V1::ChannelsController < Api::BaseController

  def index
    @channels = Channel.all.includes(:entity)
  end

  def show
    @channel = Channel.find(params[:id])
  end

end
