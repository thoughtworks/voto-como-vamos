source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails', '3.2.5'
gem "mongoid", "~> 3.0.0.rc"
gem 'jquery-rails'
gem 'heroku'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'uglifier', '>= 1.0.3'
end

group :test, :development do
  gem "rspec-rails", "~> 2.0"
end

group :test do
  gem 'capybara'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
end

group :production do
  gem 'thin'
end
