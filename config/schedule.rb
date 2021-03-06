# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron
env :PATH, '/usr/local/bin:/bin:/usr/bin:/usr/local/sbin:/usr/sbin:/sbin:/opt/aws/bin:/opt/aws/bin'

every 2.minutes do
  rake 'channels:refresh'
end

every 5.minutes do
  rake 'items:remove_stale'
end

every 10.minutes do
  rake 'admin:job_status'
end

every 1.day, :at => '7:30am' do
  rake 'mail:send_admin_report'
end

every 7.days, :at => '5:30am' do
  rake 'channels:destroy_missing_youtube_items'
end
