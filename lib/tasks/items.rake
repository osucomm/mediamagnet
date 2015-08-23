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

  desc 'Copy guid to source_identifier for everything except funds'
  task copy_guid_to_source_identifier: :environment do

    Item.all.eager_load(:channel).where("channels.type != 'FundChannel'").each do |item|
        item.update_attribute(:source_identifier, item.guid)
    end

  end

  desc 'Remove items whose links result in 404s'
  task remove_stale: :environment do
    Item.by_link_verification.limit(100).each {|i| i.destroy_on_bad_link}
  end

  desc 'Reindex recent items to workaround tag issue'
  task reindex_recent: :environment do
    Item.where('created_at > ?', 3.minutes.ago).each {|i| i.update_es_record}
  end

end
