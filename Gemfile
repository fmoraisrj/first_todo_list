source 'https://rubygems.org'

ruby '1.9.3'
gem 'rails',             '3.2.13'
gem 'strong_parameters', '0.2.1'
gem 'mongoid'
gem 'mongoid_rails_migrations', "~> 1.0.0" 
gem 'heroku'
gem 'jquery-rails'
# Devise is a flexible authentication solution for Rails based on Warden
gem "devise"


group :production do
  gem 'thin'
end

group :development, :test do
  gem 'rspec-rails', '~> 2.0'
  gem "debugger", "~> 1.6.1"
  gem "jasmine"
  gem "awesome_print", :require => 'ap'
  gem "factory_girl_rails", "~> 4.0"
end

group :test do
  gem 'database_cleaner'
end
# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'
# Framework de CSS
gem "compass", "~> 0.12.2"

#Biblioteca para ajudar com testes e TDD
gem "rspec", "~> 2.14.1"

# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails',   '~> 3.2.3'
  gem 'coffee-rails', '~> 3.2.1'

  # See https://github.com/sstephenson/execjs
  #readme for more supported runtimes
  # gem 'therubyracer', :platforms => :ruby

  gem 'uglifier', '>= 1.0.3'
end

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'
