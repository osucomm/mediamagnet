namespace :admin do
  desc 'Send admin report'
  task job_status: :environment do

    if Rails.env.production?
      total_jobs = Sidekiq::Queue.all.map(&:size).reduce(:+)
      total_workers = Sidekiq::ProcessSet.new.size
      if total_jobs > 50
        notifier = Slack::Notifier.new ENV['SLACK_URL'], 
          channel: ENV['SLACK_CHANNEL'],
          username: ENV['SLACK_USERNAME']

        notifier.ping "There are #{total_jobs} in the [sidekiq queue for media magnet](https://mediamagnet.osu.edu/admin/sidekiq). Currently there are #{total_workers} worker processes."
      end
    end
  end
end
