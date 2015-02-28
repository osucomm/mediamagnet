class Api::BaseController < ApplicationController
  respond_to :json, :xml

  after_action :set_content_type

  private

  def set_content_type
    response.headers["Content-Type"] = "#{request.format}; charset=utf-8"
  end
end