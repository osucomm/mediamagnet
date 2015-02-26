class Api::V1::ChannelsController < ApplicationController
  respond_to :json, :xml

  def index
    @channels = Channel.all.includes(:entity)
  end

  def show
    @channel = Channel.find(params[:id])
  end

end
