namespace :channels do
  desc 'Retrieve items from stale channels'
  task refresh: :environment do

    Channel.needs_refresh.each do |channel|
      channel.refresh_items
    end

  end
end
