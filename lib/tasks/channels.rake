namespace :channels do
  desc 'Retrieve items from stale channels'
  task update: :environment do

    Channel.needs_update.each do |channel|
      channel.run
    end

  end
end
