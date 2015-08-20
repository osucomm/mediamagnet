source 'https://rubygems.org'

gem 'rails', '4.2.0'

gem 'figaro'
gem 'coffee-rails', '~> 4.0.0'
gem 'daemons'
gem 'pg'
gem 'rack-cors', :require => 'rack/cors'
gem 'responders'
gem 'sanitize'
gem 'sidekiq'
gem 'uglifier', '>= 1.3.0'
gem 'whenever'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'turbolinks'
gem 'sdoc', '~> 0.4.0',          group: :doc

#Frontend
gem 'bootstrap-sass', '~> 3.3.1'
gem 'font-awesome-rails'
gem 'highcharts-rails'
gem 'htmlentities'
gem 'lazy_high_charts'
gem 'rails_autolink'
gem 'sass-rails', '~> 4.0.3'
gem 'simple_form', '~> 3.1.0.rc2'

# Auth
gem 'pundit', '~> 0.3'
gem 'omniauth'
gem 'omniauth-shibboleth'
gem 'omniauth-google-oauth2'
gem 'omniauth-facebook'

gem 'kaminari'
gem 'has_scope'
gem 'chosen-rails'
gem 'chosen-sass-bootstrap-rails'
gem 'redcarpet'

#API
gem 'versionist'
gem 'rabl'

# elasticsearch
gem 'elasticsearch-model'#, git: 'https://github.com/elastic/elasticsearch-rails'
gem 'elasticsearch-rails'#, git: 'https://github.com/elastic/elasticsearch-rails'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Channel Clients
gem 'feedjira'
gem 'httparty'
gem 'google-api-client'
gem 'instagram'
gem 'koala', '~> 1.10.1' # Facebook
gem 'twitter', '~> 5.14'
gem 'youtube_it'
gem 'icalendar'
gem 'sinatra', :require => nil

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
#
#
group :development do
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'bullet', '~> 4.13.2'
  gem 'dotenv-rails'
  gem 'guard-livereload', require: false
  gem 'meta_request'
  gem 'pry-byebug', git: 'https://github.com/deivid-rodriguez/pry-byebug'
  gem 'pry-stack_explorer'
  gem 'quiet_assets'
  gem 'rack-livereload'
  gem 'sqlite3'
  gem 'spring'
end

group :test do
  gem 'capybara'
  gem 'database_cleaner', '~> 1.3'
  gem 'launchy'
  gem 'poltergeist'
  gem 'rspec', '~> 3.0.0'
  gem 'rspec-rails','~> 3.0.0'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'rspec-given'
  gem 'rubocop', require: false
end

group :development, :test do
  gem 'childprocess'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'guard'
  gem 'guard-rspec'
  gem 'pry'
  gem 'railroady', git: 'https://github.com/preston/railroady.git'
  gem 'spring-commands-rspec'
  gem 'jasmine', '~> 2.0.2' # js testing framework
  gem 'mailcatcher'
  gem 'terminal-notifier-guard'
end

group :production do
  gem 'redis-rails'
end

# Use debugger
# gem 'debugger', group: [:development, :test]

