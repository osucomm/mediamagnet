class KeywordingsController < ApplicationController

  respond_to :html, :js

  def new
    @keywording = Keywording.new(keywordable_type: params[:keywordable_type], keywordable_id: params[:keywordable_id])
    authorize @keywording
    respond_with @mapping
  end

  def create
    @keywording = Keywording.new(keywording_params)
    authorize @keywording

    if @keywording.save
      respond_with @keywording
    else
      respond_to do |format|
        format.json { render :json => { :error => @keywording.errors.full_messages }, :status => 422 }
      end
    end

  end

  def destroy
    @keywording = Keywording.find(params[:id])
    authorize @keywording
    @keywording.destroy
    respond_with @keywording
  end

  private

  def keywording_params
    params.require(:keywording).permit(:keywordable_id, :keywordable_type, :keyword_id)
  end
end
