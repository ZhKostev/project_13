require File.expand_path('../boot', __FILE__)

require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "sprockets/railtie"

# Assets should be precompiled for production (so we don't need the gems loaded then)
Bundler.require(*Rails.groups(assets: %w(development test)))

module Project13
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    config.i18n.default_locale = :ru

    config.generators do |g|
      g.test_framework :rspec, :view_specs => false, :fixture => true, :fixture_replacement => "factory_girl", :routing_specs => false
    end

    config.assets.precompile += ['admin/admin.js', 'admin/admin.css']

    config.autoload_paths << "#{Rails.root}/app/services"
  end
end

INTERNAL_SERVER_ERROR_EMAIL_RECIPIENTS = %w{zh.kostev@gmail.com mustang1365@mail.ru}
SUPPORTED_LANGUAGES = [:ru, :en]

