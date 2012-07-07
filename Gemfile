source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails', '3.2.5'
gem 'jquery-rails'
gem 'heroku'
gem 'omniauth-facebook'
gem 'koala'
gem 'slim'
gem 'factory_girl_rails'
gem 'valid_email'
gem 'simple_form'
gem 'tire'

group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  gem 'uglifier', '>= 1.0.3'
end

group :test, :development do
  gem 'debugger'
  gem 'rspec-rails', '~> 2.0'
  gem 'pry'
  gem 'launchy'
  gem 'sqlite3'
  gem 'hitch'
  gem 'spork'
end

group :test do
  gem 'capybara'
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
  gem 'shoulda-matchers'
  gem 'simplecov', :require => false
  gem 'email_spec'
end

group :production do
  gem 'thin'
  gem 'pg'
end
