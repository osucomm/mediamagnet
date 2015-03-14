module Itemable
  extend ActiveSupport::Concern

  private

  def search_params(params)
    filters = params.except(:search)
    filters['channel_type'] ||= ['twitter', 'instagram', 'rss', 'events rss feed', 'facebook page', 'youtube playlist', 'icalendar']
    [params[:search], filters]
  end

end
