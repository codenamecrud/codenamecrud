source 'https://rubygems.org'

gem 'rails', '4.2.1'
gem 'pg'

gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'jquery-rails'
gem 'jbuilder', '~> 2.0'

gem 'bootstrap-sass', '~> 3.3.3'
gem 'font-awesome-sass', '~> 4.3.0'
gem 'slim-rails'
gem 'simple_form'
gem 'figaro'
gem 'rails-i18n'
gem 'friendly_id'
gem 'github_api'
gem 'kramdown'
gem 'disqus_rails'
gem 'devise', '~> 3.5.1'
gem 'omniauth-github'
gem 'paper_trail', '~> 4.0.0.beta'
gem 'will_paginate'

group :development, :test do
  gem 'byebug'
  gem 'web-console', '~> 2.0'
  gem 'spring'
  gem 'pry-rails'
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'guard-rspec', require: false
  gem 'letter_opener'
end

group :development do
  gem 'capistrano', github: 'capistrano/capistrano', ref: '96a16'
end

group :test do
  gem 'capybara', '~> 2.4.0'
  gem 'launchy', '~> 2.4'
  gem 'database_cleaner', '~> 1.3'
  gem 'shoulda-matchers', require: false
  gem 'codeclimate-test-reporter', require: nil
  gem 'capybara-webkit'
  gem 'email_spec'
end

group :production do
  gem 'unicorn'
  gem 'rollbar', '~> 1.5.1'
  gem 'newrelic_rpm'
end
