class ErrorsController < ApplicationController

  def show
    @error = Error.new(status_code, request.format.html?)
    render 'show', :status => status_code
  end
 
protected
 
  def status_code
    params[:status].to_i || 500
  end
 
end
