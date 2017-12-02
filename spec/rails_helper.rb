ENV['RAILS_ENV'] = 'test'

require File.expand_path('../../config/environment', __FILE__)
abort('DATABASE_URL environment variable is set') if ENV['DATABASE_URL']

include ActionDispatch::TestProcess

require 'rspec/rails'
require 'selenium/webdriver'

Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |file| require file }

module SystemHelpers
  include Formulaic::Dsl
  include Monban::Test::Helpers
  include SignedUpUser
end

RSpec.configure do |config|
  config.include SystemHelpers, type: :system
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = true

  config.after(:each) do
    Monban.test_reset!
  end

  config.after(:suite) do
    FileUtils.rm_rf(Dir["#{Rails.root}/spec/test_files/"])
  end
end

ActiveRecord::Migration.maintain_test_schema!
Monban.test_mode!
