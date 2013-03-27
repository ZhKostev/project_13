Project13::Application.configure do
  config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
  config.i18n.default_locale = :ru
end