require_relative 'boot'

require "rails"
# Pick the frameworks you want:
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "action_cable/engine"
# require "sprockets/railtie"
require "rails/test_unit/railtie"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module RBets
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Only loads a smaller set of middleware suitable for API only apps.
    # Middleware like session, flash, cookies can be added back manually.
    # Skip views, helpers and assets when generating a new resource.
    config.log_level = :debug
    config.log_tags  = [:subdomain, :uuid]
    config.logger    = ActiveSupport::TaggedLogging.new(Logger.new(STDOUT))

    config.cache_store = :redis_store, ENV['CACHE_URL'],
                         { namespace: 'r-bets-backend::cache' }

    # Set Redis as the back-end for the cache.
    config.cache_store = :redis_store, ENV['REDIS_CACHE_URL']

    config.middleware.use Rack::Attack

    config.active_job.queue_adapter = :sidekiq
    config.active_job.queue_name_prefix =
        "#{ENV['ACTIVE_JOB_QUEUE_PREFIX']}_#{Rails.env}"

    # Action Cable setting to de-couple it from the main Rails process.
    config.action_cable.url = ENV['ACTION_CABLE_FRONTEND_URL']

    # Action Cable setting to allow connections from these domains.
    origins = ENV['ACTION_CABLE_ALLOWED_REQUEST_ORIGINS'].split(',')
    origins.map! { |url| /#{url}/ }
    config.action_cable.allowed_request_origins = origins

    config.active_record.raise_in_transactional_callbacks = true
    config.api_only = true

  end
end

