# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron
env :PATH, '/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/aws/bin:/opt/aws/bin'

every 1.minutes do
  rake 'channels:refresh'
end

every 1.minutes do
  rake 'items:remove_stale'
end

every :monday, :at => '12:01am' do
  rake 'keyword_usages:generate_weekly_totals'
end
