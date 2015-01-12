namespace :channels do
  desc 'Retrieve items from stale channels'
  task refresh: :environment do

    Channel.needs_refresh.each do |channel|
      channel.refresh_items
    end

    Keyword.all.each do |keyword|
      keyword.update_attributes(item_counter: keyword.items.count)
    end

  end
end
