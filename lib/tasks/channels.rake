namespace :channels do
  desc 'Retrieve items from stale channels'
  task refresh: :environment do

    Channel.needs_refresh.each do |channel|
      channel.refresh_items
    end

    Keyword.all.each do |keyword|
      # Do we need this anymore?
      #keyword.update_attributes(item_counter: keyword.item_count)
    end

  end
end
