namespace :channels do
  desc 'Retrieve items from stale channels'
  task refresh: :environment do

    Channel.needs_refresh.limit(40).each do |channel|
      channel.refresh
    end

  end

  desc 'Update channel types to new names'
  task rename_channels: :environment do

    Channel.where(type: 'WebChannel').each {|i| i.update_attribute(type: 'RssChannel') }
    Channel.where(type: 'EventChannel').each {|i| i.update_attribute(type: 'EventRssChannel') }

  end

  desc 'Notify stale channels'
  task notify_stale: :environment do
    Channel.stale_for_days(30).each {|channel| AdminReportMailer.stale_channels(channel).deliver}
  end

end
