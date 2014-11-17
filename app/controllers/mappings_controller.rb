class MappingsController < ApplicationController

  respond_to :html, :js

  def new
    @mapping = mapping_type.new(mappable_type: params[:mappable_type], mappable_id: params[:mappable_id])
    respond_with @mapping
  end

  def create
    @mapping = mapping_type.new(mapping_params)
    authorize @mapping

    if @mapping.save!
      respond_with @mapping
    else
      redirect_to '/'
    end
  end


  def update
  end

  def destroy
    @mapping = Mapping.find(params[:id])
    @mapping.destroy
    flash[:success] = "Mapping was deleted."
    respond_with @mapping
  end

  private

  def mapping_params
    params.require(:mapping).permit(:tag_id, :tag_text, :keyword_id, :mappable_id, :mappable_type)
  end

  def mapping_type
    params[:type] ? params[:type].constantize : Mapping
  end

end
