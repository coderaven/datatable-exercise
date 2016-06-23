require 'sidekiq'

Sidekiq.configure_client do |config|
  config.redis = { size: 1, url: ENV['REDISCLOUD_URL'] || 'redis://localhost:6379/' }
end

Sidekiq.configure_server do |config|
  config.redis = { size: 27, url: ENV['REDISCLOUD_URL'] || 'redis://localhost:6379/' }
end