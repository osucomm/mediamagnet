class ChannelsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_channel, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json, :js

  def index
    respond_with @channels = channel_type.all.page(params[:page])
                                             .per(params[:per_page])
  end

  def show
    respond_with @channel
  end

  def new
    # TODO: Refactor out YouTube oauth2 stuff. 
    if (channel_type == YoutubePlaylistChannel && session[:token_id].nil?)
      redirect_to '/auth/google_oauth2'
    end

    @channel = channel_type.new

    # More youtube oauth2 stuff.
    if (channel_type == YoutubePlaylistChannel && session[:token_id].nil?)
      @channel.token = Token.find(session[:token_id])
      @channel.load_service_identifier
    end

    @entity = Entity.find(params[:entity_id])
    @channel.entity = @entity
    @channel.build_contact
    authorize @channel
  end

  def create
    @channel = channel_type.new(channel_params)
    @channel.token = Token.find(session[:token_id]) if session[:token_id]
    @channel.entity = Entity.find(params[:entity_id])
    authorize @channel

    @channel.contact = nil if @channel.contact.try(:empty?)

    if @channel.save
      respond_with @channel
    else
      respond_with @channel do |format|
        format.html { render :new }
      end
    end
  end

  def edit
    authorize @channel
    @channel.build_contact unless @channel.contact
  end

  def update
    authorize @channel

    if @channel.update channel_params
      respond_with @channel
    else
      respond_with @channel do |format|
        format.html { render :edit }
      end
    end
  end

  def destroy
    @entity = @channel.entity
    @channel.destroy
    flash[:notice] = "Channel was successfully destroyed."
    respond_with @channel, location: @entity
  end


  private

    def channel_params
      params.require(:channel).permit(:name, :description, :service_identifier, :url, :primary,
        :keyword_ids => [], contact_attributes: [:id, :name, :organization, :url, :phone, :email])
    end

    def channel_type
      params[:type] ? params[:type].constantize : Channel
    end

    def find_channel
      @channel = channel_type.includes(:entity).find(params[:id])
    end

end
