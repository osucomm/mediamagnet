class ItemFactory

  class << self
    def create_or_update_from_hash(item_hash, channel)
      #Item exists
      if item = channel.items.find_by_source_identifier(item_hash[:source_identifier])
        #Item needs update
        if item.digest != item_hash[:digest]
          #Update
          item.update(
            item_hash.slice(
              :title, :source_identifier, :content, :description, :digest, :published_at
            )
          )
          item.assets.destroy_all
          item_hash[:asset_urls].each do |url|
            item.assets.where(url: url).first_or_create
          end

          item.link = Link.where(url: item_hash[:link] ? item_hash[:link] : item.url).first_or_create
          item.tag_names = item_hash[:tag_names]

          if item_hash[:events]
            item_hash[:events].each do |ev|
              event = item.events.first
              event.update(
                start_date: ev[:start_date],
                end_date: ev[:end_date],
                location_id: Location.where(location: ev[:location]).first_or_create.id
              )
            end
          end
          item.save
          item.update_es_record
        end

      else
        #Create
        item = channel.items.create(
          item_hash.slice(
            :title, :source_identifier, :content, :description, :digest, :published_at
          )
        )

        item_hash[:asset_urls].each do |url|
          item.assets.create(url: url)
        end

        item.link = Link.where(url: item_hash[:link] ? item_hash[:link] : item.url).first_or_create
        item.tag_names = item_hash[:tag_names]
        item.keywords << channel.all_keywords

        if item_hash[:events]
          item_hash[:events].each do |ev|
            item.events.create(
              start_date: ev[:start_date],
              end_date: ev[:end_date],
              location_id: Location.where(location: ev[:location]).first_or_create.id
            )
          end
        end

        item.save
        item.update_es_record
      end

    end
  end

end
