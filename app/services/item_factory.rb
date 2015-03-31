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

          if item_hash[:tag_names]
            item.tag_names = item_hash[:tag_names]
          end

          item.assets.destroy_all

          item_hash[:asset_urls].each do |url|
            item.assets.where(url: url).first_or_create
          end

          if item_hash[:events]
            item_hash[:events].each do |ev|
              event = item.events.first
              event.update(
                start_date: ev[:start_date],
                end_date: ev[:end_date],
                location_id: Location.where(location: ev[:location]).first_or_create
              )
            end
          end

          item.save

        end
      else
        #Create
        item = channel.items.create(
          item_hash.slice(
            :title, :source_identifier, :content, :description, :digest, :published_at
          )
        )
        if item_hash[:tag_names]
          item.tag_names = item_hash[:tag_names]
        end
        item_hash[:asset_urls].each do |url|
          item.assets.create(url: url)
        end

        item.keywords << channel.keywords

        if item_hash[:events]
          item_hash[:events].each do |ev|
            event = item.events.create(
              start_date: ev[:start_date],
              end_date: ev[:end_date],
            )
            event.location = Location.where(location: ev[:location]).first_or_create
          end
        end

      end

      item.save
    end
  end

end
