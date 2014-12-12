require 'net/http'

namespace :keywords do
  desc 'Retrieve items from stale channels'
  task import_from_ucom: :environment do

    response = Net::HTTP.get_response("ucom.osu.edu","/media-magnet/mm-tags.js")
    raise 'Invalid response' unless response.code == "200"

    keywords = JSON.parse(response.body)
    keywords.each do |keyword|
      k = Keyword.where(name: keyword['name'],
                        display_name: keyword['display_name'],
                        description: keyword['description']).first_or_initialize
      if k.new_record?
        k.category = keyword['category']
        k.save
        puts "Created new keyword #{keyword['name']}"
      end
    end

  end

end
