source 'https://rubygems.org'

gem 'coffee-rails', '~> 4.0.0'
gem 'rails', '4.1.6'
gem 'spring',        group: :development
gem 'sqlite3'
gem 'therubyracer',  platforms: :ruby
gem 'uglifier', '>= 1.3.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
gem 'sdoc', '~> 0.4.0',          group: :doc

#Frontend
gem 'bootstrap-sass', '~> 3.2.0.1'
gem 'sass-rails', '~> 4.0.3'
gem 'simple_form', '~> 3.0.1'

# Auth
gem 'pundit', '~> 0.2.3'

#Soft Deletion
gem 'paranoia', github: 'radar/paranoia', branch: 'rails4'



# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development
#
#
group :development do
  gem 'better_errors'
  gem 'binding_of_caller'

  #gem 'capistrano', '~> 3.2.0'
  #gem 'capistrano-sidekiq'
  #gem 'capistrano-rails'
  #gem 'capistrano-rvm'
  #gem 'capistrano-bundler'

  gem 'meta_request'
  gem 'pry'
  #gem 'pry-doc'
  #gem 'pry-rescue'
  gem 'pry-stack_explorer'
  gem 'pry-byebug', git: 'https://github.com/deivid-rodriguez/pry-byebug'
  gem 'quiet_assets'
  gem 'guard-livereload', require: false
  gem 'rack-livereload'

  gem 'bullet', '~> 4.13.2'
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

