RSpec.configure do |config|
  config.before(:each) do
    Capybara.app_host = 'http://example.com'
  end
end
