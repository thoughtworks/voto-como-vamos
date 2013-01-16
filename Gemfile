source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails', '3.2.11'
gem 'jquery-rails'
gem 'heroku'
gem 'omniauth-facebook'
gem 'koala'
gem 'slim'
gem 'valid_email'
gem 'simple_form'
gem 'will_paginate', '~> 3.0'
gem 'sunspot_rails'
gem 'newrelic_rpm'
gem 'exception_notification'
gem 'rails_autolink'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'uglifier', '>= 1.0.3'
end

group :test, :development do
  gem 'nyan-cat-formatter'
  gem 'rspec-rails', '~> 2.0'
  gem 'pry'
  gem 'launchy'
  gem 'sqlite3'
  gem 'hitch'
  gem 'spork'
  gem 'progress_bar'
  gem 'factory_girl_rails'
end

group :test do
  gem 'capybara'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem 'shoulda-matchers', '~> 1.2'
  gem 'simplecov', :require => false
  gem 'email_spec'
  gem 'selenium-webdriver', '2.25.0'
end

group :development do
  gem 'debugger'
end

group :production do
  gem 'thin'
  gem 'pg'
end
