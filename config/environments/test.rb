Rails.application.configure do
  config.action_controller.allow_forgery_protection = false
  config.action_controller.perform_caching = false
  config.action_dispatch.show_exceptions = false
  config.action_mailer.default_url_options = { host: 'example.com' }
  config.action_mailer.delivery_method = :test
  config.action_mailer.perform_caching = false
  config.active_support.deprecation = :stderr
  config.cache_classes = true
  config.consider_all_requests_local = true
  config.eager_load = false
  config.public_file_server.enabled = true
  config.public_file_server.headers = {
    'Cache-Control' => 'public, max-age=3600'
  }
  routes.default_url_options[:host] = 'http://example.com'
end
