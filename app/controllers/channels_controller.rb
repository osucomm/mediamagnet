class ChannelsController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_channel, only: [:show, :edit, :update, :destroy]
  before_action :get_token, only: [:new]
  before_action :preserve_action_redirect!, only: [:show, :edit]

  respond_to :html, :json, :js

  def index
    @channels = channel_type.all.page(params[:page]).
                                      per(params[:per_page])
    authorize @channels
    respond_with @channels
  end

  def show
    respond_with @channel
  end

  def new
    @channel = channel_type.new

    # More youtube oauth2 stuff.
    if (channel_type == YoutubePlaylistChannel)
      @channel.token = Token.find(session[:token_id])
      @channel.load_service_identifier
      @channel.name = params[:name]
    end

    @entity = Entity.find(current_user.current_entity_id)
    @channel.entity = @entity
    @channel.build_contact
    authorize @channel
  end

  def create
    @channel = channel_type.new(channel_params)
    @channel.token = Token.find(session[:token_id]) if session[:token_id]
    @channel.entity = Entity.find(params[:entity_id])
    authorize @channel

    @channel.build_contact
    #@channel.contact = nil if @channel.contact.try(:empty?)

    if @channel.save
      respond_with @channel do |format|
        format.html { render :edit }
      end
    else
      respond_with @channel do |format|
        format.html { render :new }
      end
    end
  end

  def edit
    @channel.build_contact unless @channel.contact
  end

  def update
    if @channel.update channel_params
      flash[:success] = "#{@channel.name} #{@channel.type_name.downcase} channel has been updated."
      respond_with @channel
    else
      respond_with @channel do |format|
        format.html { render :edit }
      end
    end
  end

  def destroy
    authorize @channel
    @entity = @channel.entity
    @channel.destroy
    flash[:success] = "#{@channel.name} #{@channel.type_name.downcase} channel was successfully deleted."
    respond_with @channel do |format|
      format.html { redirect_or_respond_with @channel }
      format.js { }
    end
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
      authorize @channel
    end

    def get_token
      if (channel_type == YoutubePlaylistChannel && session[:token_id].nil?)
        redirect_to auth_path(:google_oauth2)
      end
    end

end
