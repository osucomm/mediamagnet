namespace :items do
  desc 'Create links from link string fields on items'
  task buildlinks: :environment do

    Item.all.each do |item|
      item.link = Link.where(url: item.attributes['link']).create if item.link.nil?
      item.save!
    end

  end

  desc 'Create links from link string fields on items'
  task parselinks: :environment do

    Item.all.each do |item|
      item.send(:links_from_text_fields)
      item.save!
    end

  end

end