if Rails.env.production? && ENV['ELASTICSEARCH_ADDRESS_INT']
  User.__elasticsearch__.client = Elasticsearch::Client.new host: ENV['ELASTICSEARCH_ADDRESS_INT']
end
