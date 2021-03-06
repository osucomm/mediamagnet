if Rails.env.production?
  Sidekiq.configure_server do |config|
    config.redis = { url: "redis://#{Figaro.env.REDIS_HOST}:#{Figaro.env.REDIS_PORT}" }
  end
  Sidekiq.configure_client do |config|
    config.redis = { url: "redis://#{Figaro.env.REDIS_HOST}:#{Figaro.env.REDIS_PORT}" }
  end
end
