source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.5.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.5'
# Use postgresql as the database for Active Record
gem 'pg', '>= 0.18', '< 2.0'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
# Active Designer for DB Schema Photos
gem 'active_designer'
# Figaro for ENV variables
gem 'figaro'
# Faraday for API calls
gem 'faraday'
# Fast JSON API for serializers
gem 'fast_jsonapi'
# Redis
gem 'redis-rails'
gem 'redis-namespace'
gem 'redis'
gem 'redis-rack-cache'
gem 'mock_redis'

group :development, :test do
  gem 'pry'
  gem 'rspec-rails', '~> 4.0.1'
  gem 'capybara'
  gem 'shoulda-matchers', '~> 3.1'
  gem 'orderly'
  gem 'simplecov'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'rubocop-rails'
  gem 'brakeman'
end

group :test do
  gem 'vcr'
  gem 'webmock'
  gem 'timecop'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
