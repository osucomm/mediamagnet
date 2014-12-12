class KeywordUsage < ActiveRecord::Base
  belongs_to :keyword
  belongs_to :channel

  class << self
    def generate_weekly_totals
      starts_at = 1.week.ago
      ends_at = Time.now
      Keyword.all.each do |keyword|
        Channel.all.each do |channel|
          count = keyword.all_items_this_week_for_channel(channel.id).count
          create(
            keyword: keyword,
            channel: channel,
            count: count,
            starts_at: starts_at,
            ends_at: ends_at
          )
        end
      end
    end
  end

end
