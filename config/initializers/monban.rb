Monban.configure do |config|
  config.sign_in_notice = -> { I18n.t('helpers.error.session.unauthorized') }
end
