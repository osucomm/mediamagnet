require 'net/http'

namespace :keyword_usages do
  desc 'Preserve counts for keyword usage by channel'
  task generate_weekly_totals: :environment do

    KeywordUsage.generate_weekly_totals

  end

end
