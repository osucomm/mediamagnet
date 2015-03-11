if Rails.env.production? && ENV['ELASTICSEARCH_ADDRESS_INT']
  Item.__elasticsearch__.client = Elasticsearch::Client.new host: ENV['ELASTICSEARCH_ADDRESS_INT']
end
