# frozen_string_literal: true

require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module LocalTrackApp
  class Application < Rails::Application
    config.active_record.default_timezone = :local
    config.api_only = true
    config.autoload_lib(ignore: %w[assets tasks])
    config.load_defaults 8.0
    config.time_zone = 'America/New_York'
  end
end
