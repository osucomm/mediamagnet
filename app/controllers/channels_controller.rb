class ChannelsController < ApplicationController

  before_action :authenticate_user!

  respond_to :html, :js

  def index
    @channels = channel_type.all
  end

  def show
    @channel = channel_type.includes(:entity).find(params[:id])
  end

  def new
    @channel = channel_type.new
    @channel.entity = Entity.find(params[:entity_id])
    authorize @channel
  end

  def create
    puts params.to_yaml
    @channel = channel_type.new(channel_params)
    authorize @channel

    if @channel.save
      respond_with @channel
    else
      response_with @channel do |format|
        format.html { render :new }
      end
    end
  end

  def edit
    authorize @channel
  end

  def update
    authorize @channel
  end

  def destroy
    authorize @channel
  end


  def channel_type
    params[:type] ? params[:type].constantize : Channel
  end

  def channel_params
    params.require(:channel).permit(:name, :description, :service_identifier, :url, :primary)
  end

end
