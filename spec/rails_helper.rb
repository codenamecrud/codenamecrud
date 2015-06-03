require "codeclimate-test-reporter"
CodeClimate::TestReporter.start
ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'
require 'shoulda/matchers'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

Capybara.javascript_driver = :webkit

RSpec.configure do |config|
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.include FactoryGirl::Syntax::Methods
  config.include UsersHelpers
  config.include WaitForAjaxHelpers
  config.include Capybara::DSL
  config.include Devise::TestHelpers, :type => :controller
  config.extend ControllerHelpers, :type => :controller
  # config.include OmniauthHelpers
  config.before(:all) { FactoryGirl.reload }
  config.before(:suite) { DatabaseCleaner.clean_with :truncation }
  config.before(:each) { DatabaseCleaner.strategy = :transaction }
  config.before(:each, js: true) { DatabaseCleaner.strategy = :truncation }
  config.before(:each) { DatabaseCleaner.start }
  config.after(:each) { DatabaseCleaner.clean }
end

OmniAuth.config.test_mode = true
omniauth_hash = {
  provider: 'github',
  uid: '12345',
  info: {
    name: 'Example User',
    email: 'example@user.com',
    nickname: 'Example User'
  },
  extra: { raw_info:
           { location: 'San Francisco',
             gravatar_id: '123456789'
             }
           }
}

OmniAuth.config.add_mock(:github, omniauth_hash)
