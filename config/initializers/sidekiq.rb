sidekiq_config = { url: ENV['ACTIVE_JOB_URL'] }

Sidekiq.configure_server do |config|
  config.redis = { url: ENV['ACTIVE_JOB_URL'] }
end

Sidekiq.configure_client do |config|
  config.redis = sidekiq_config
end
