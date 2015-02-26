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

  desc 'Rebuild elasticsearch index and import items.'
  task es_rebuild: :environment do

    puts 'Deleting current index...'
    Item.__elasticsearch__.client.indices.delete index: Item.index_name rescue nil
    puts 'Index deleted. Creating new index...'
    Item.__elasticsearch__.client.indices.create \
      index: Item.index_name,
      body: { settings: Item.settings.to_hash, mappings: Item.mappings.to_hash }
    puts 'Index created. Importing items...'

    Item.import

  end


end
