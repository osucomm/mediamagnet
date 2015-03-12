module Itemable
  extend ActiveSupport::Concern

  private

  def search_params(params)
    filters = params.except(:search)
    filters['channel_type'] ||= %w(twitter instagram rss event_rss facebook_page youtube_platlist icalendar)
    [params[:search], filters]
  end

end
