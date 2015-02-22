source 'https://rubygems.org'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails'

# Use sqlite3 as the database for Active Record
group :development, :test do
    gem 'sqlite3'
    gem 'rspec-rails'
end

group :test do
  gem 'factory_girl_rails'
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'database_cleaner'
  gem 'launchy'
  gem 'simplecov', require: false
  gem 'webmock'
end

group :production do
    gem 'pg'
    gem 'rails_12factor'
end

# Use SCSS for stylesheets
gem 'sass-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'

# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

gem 'jquery-turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
gem 'bcrypt-ruby'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
gem 'byebug', group: [:development, :test]

# Use HTTParty
gem 'httparty'

# Use rails-settings-cached
gem 'rails-settings-cached'

gem 'bootstrap-sass'
group 'development' do
  gem 'rails_layout'
end
