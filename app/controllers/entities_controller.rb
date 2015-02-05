class EntitiesController < ApplicationController

  before_action :authenticate_user!, except: [:index, :show]
  before_action :find_entity, only: [:show, :edit, :update, :destroy]

  respond_to :html, :json, :js

  def index
    @entities = Entity.all
    authorize @entities
    respond_with @entities
  end

  def show
    current_user.update_attributes(current_entity: @entity) if current_user
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
      EntityMailer.register_email(@entity).deliver_later unless @entity.approved
      respond_with @entity
    else
      respond_with @entity do |format|
        format.html { render :new }
      end
    end
  end

  def edit
    @entity.build_contact unless @entity.contact
  end

  def update
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
    flash[:success] = "#{@entity.name} has been deleted."

    if flash[:delete_redirect]
      respond_with @entity, location: flash[:delete_redirect]
    else
      respond_with @entity
    end
  end

  private

    def entity_params
      params.require(:entity).permit(*policy(@entity || Entity).permitted_attributes)
    end

    def find_entity
      @entity = Entity.includes(:channels, :users).find(params[:id])
      authorize @entity
    end
end
