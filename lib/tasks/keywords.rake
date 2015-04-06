require 'net/http'

namespace :keywords do
  desc 'Load keywords from UCOM website'
  task import_from_ucom: :environment do

    response = Net::HTTP.get_response("ucom.osu.edu","/media-magnet/mm-tags.js")
    raise 'Invalid response' unless response.code == "200"

    keywords = JSON.parse(response.body)
    keywords.each do |keyword|
      k = Keyword.where(name: keyword['name'],
                        display_name: keyword['display_name'],
                        description: keyword['description']).first_or_initialize
      if k.new_record?
        unless keyword['category'].blank?
          k.category = Category.where(name: keyword['category']).first_or_create
        end

        k.save
        puts "Created new keyword #{keyword['name']}"
      end
    end

  end


  desc 'Load keywords from Media Magnet'
  task import_from_mm: :environment do

    http = Net::HTTP.new("mediamagnet.osu.edu", 443)
    http.use_ssl = true
    response = http.get("/api/keywords.json")
    raise 'Invalid response' unless response.code == "200"

    data = JSON.parse(response.body)
    data['keywords'].each do |keyword|
      k = Keyword.where(name: keyword['name'],
                        display_name: keyword['display_name'],
                        description: keyword['description']).first_or_initialize
      if k.new_record?
        unless keyword['category'].blank?
          k.category = Category.where(name: keyword['category']).first_or_create
        end

        k.save
        puts "Created new keyword #{keyword['name']}"
      end
    end

  end

end
