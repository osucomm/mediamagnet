class EntitiesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_entity, only: [:show, :edit, :update, :destroy]

  respond_to :html, :xml, :json, :js

  def index
    @entities = Entity.all
    respond_with @entities
  end

  def show
    respond_with @entity
  end

  def new
    @entity = Entity.new
    authorize @entity
    @entity.build_contact
  end

  def create
    @entity = Entity.new(entity_params)
    authorize @entity

    @entity.contact = nil if @entity.contact.try(:empty?)
    @entity.users << current_user

    if @entity.save
      respond_with @entity
    else
      respond_with @entity do |format|
        format.html { render :new }
      end
    end
  end

  def edit
    authorize @entity
    @entity.build_contact unless @entity.contact
  end

  def update
    authorize @entity

    if @entity.update entity_params
      respond_with @entity
    else
      respond_with @entity do |format|
        format.html { render :edit }
      end
    end
  end

  def destroy
    @entity.destroy
    flash[:success] = "Entity was successfully destroyed."
    respond_with @entity
  end

  private

    def entity_params
      params.require(:entity).permit(:name, :description, :link, :keyword_ids => [],
        contact_attributes: [:id, :name, :organization, :url, :phone, :email])
    end

    def find_entity
      @entity = Entity.includes(:channels, :users).find(params[:id])
    end
end
