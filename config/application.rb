require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Datatables
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration can go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded after loading
    # the framework and any gems in your application.

    # Locales
    config.i18n.load_path        += Dir[Rails.root.join('config', 'locales', '**', '*.yml').to_s]
    config.i18n.default_locale    = :fr
    config.i18n.available_locales = %i[fr]
  end
end
