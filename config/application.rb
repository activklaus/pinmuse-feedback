# frozen_string_literal: true

require_relative 'boot'

require 'rails'
require 'active_model/railtie'
require 'active_record/railtie'
require 'action_controller/railtie'

Bundler.require(*Rails.groups)

module PinmuseFeedback
  class Application < Rails::Application
    config.load_defaults 7.1
    config.api_only = true

    config.time_zone = 'Berlin'
    config.active_record.default_timezone = :utc
  end
end
