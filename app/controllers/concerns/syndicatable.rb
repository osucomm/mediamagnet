module Syndicatable
  extend ActiveSupport::Concern

  included do
    respond_to :rss, only: :index
    before_action :set_rss_channel, only: :index
  end

  private

  def set_rss_channel
    # If the request is RSS and for a single channel, grab the channel model
    if request.format.rss? and params.key?(:channel_id)
      @channel = Channel.find(params[:channel_id]) unless params[:channel_id].is_a? Array
    end
  end

end