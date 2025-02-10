require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module WorkerApp
  class Application < Rails::Application
     require "carrierwave/orm/activerecord"
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 8.0

    # Please, add to the `ignore` list any other `lib` subdirectories that do
    # not contain `.rb` files, or that should not be reloaded or eager loaded.
    # Common ones are `templates`, `generators`, or `middleware`, for example.
    config.autoload_lib(ignore: %w[assets tasks])

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #

    config.time_zone = "Kolkata"
    # config.eager_load_paths << Rails.root.join("extras")
    Twilio.configure do |config|
      config.account_sid = "AC880628ac290278ba72c063ac93deaf33",
      config.auth_token = "d1bdd8735de0686ce2dd68bc2667416b"
    end
  end
end
