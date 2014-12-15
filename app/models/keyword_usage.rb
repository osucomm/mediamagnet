class KeywordUsage < ActiveRecord::Base
  belongs_to :keyword
  belongs_to :channel

  scope :by_channels, -> (channel_ids) { where(channel_id: channel_ids) }

  class << self
    def generate_weekly_totals
      last_week = Time.now.strftime('%W').to_i - 1
      year = Time.now.strftime('%Y').to_i
      starts_at = Time.now.beginning_of_week.yesterday.beginning_of_week
      ends_at = Time.now.beginning_of_week.yesterday.end_of_week
      Keyword.all.each do |keyword|
        Channel.all.each do |channel|
          count = keyword.all_items.between(starts_at, ends_at).by_channels(channel.id).count
          create(
            keyword: keyword,
            channel: channel,
            count: count,
            starts_at: starts_at,
            ends_at: ends_at,
            week_number: last_week,
            year: year
          )
        end
      end
    end
  end

end
