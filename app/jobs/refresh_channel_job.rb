class RefreshChannelJob < ActiveJob::Base
  def perform(channel)
    channel.refresh_items
  end
end
