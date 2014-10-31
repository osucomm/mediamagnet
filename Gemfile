ruby '2.0.0'
source 'https://rubygems.org'


gem 'coffee-rails', '~> 4.0.0'
gem 'jbuilder', '~> 2.0'
gem 'pg'
gem 'rails', '4.1.6'
gem 'rails_12factor', group: :production
gem 'spring',        group: :development
gem 'therubyracer',  platforms: :ruby
gem 'uglifier', '>= 1.3.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'turbolinks'
gem 'sdoc', '~> 0.4.0',          group: :doc

#Frontend
gem 'bootstrap-sass', '~> 3.2.0.1'
gem 'sass-rails', '~> 4.0.3'
gem 'simple_form', '~> 3.1.0.rc2'

# Auth
gem 'pundit', '~> 0.2.3'
gem 'devise'

gem 'kaminari'

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
gem 'unicorn'

# Channel Clients
gem 'instagram'
gem 'koala', '~> 1.10.1' # Facebook
gem 'twitter'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
#
#
group :development do
  #gem 'capistrano', '~> 3.2.0'
  #gem 'capistrano-bundler'
  #gem 'capistrano-rails'
  #gem 'capistrano-rvm'
  #gem 'capistrano-sidekiq'
  #gem 'pry-doc'
  gem 'pry-rescue'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'bullet', '~> 4.13.2'
  gem 'dotenv-rails'
  gem 'guard-livereload', require: false
  gem 'meta_request'
  gem 'pry'
  gem 'pry-byebug', git: 'https://github.com/deivid-rodriguez/pry-byebug'
  gem 'pry-stack_explorer'
  gem 'quiet_assets'
  gem 'rack-livereload'
  gem 'sqlite3'
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
  gem 'guard'
  gem 'guard-rspec'
  gem 'guard-spring'
  gem 'railroady', git: 'https://github.com/preston/railroady.git'
  gem 'spring-commands-rspec'
  gem 'jasmine', '~> 2.0.2' # js testing framework
  gem 'mailcatcher'
end


# Use debugger
# gem 'debugger', group: [:development, :test]

