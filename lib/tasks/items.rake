namespace :items do
  desc 'Create links from link string fields on items'
  task buildlinks: :environment do

    Item.each do |item|
      item.link = Link.where(url: item.attributes['link']).create if item.link.nil?
      item.save!
    end

  end
end
