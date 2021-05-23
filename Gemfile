# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.0.1'

gem 'bootsnap', '>= 1.4.2', require: false
gem 'pg'
gem 'puma'
gem 'rails'
gem 'sass-rails'

# Redis
gem 'hiredis'
gem 'redis'

gem 'action_policy'
gem 'dry-validation'
gem 'enumerize'
gem 'money-rails'
gem 'reform'
gem 'reform-rails'
gem 'rolify'
gem 'telegram-bot'
gem 'trailblazer'
gem 'trailblazer-developer'
gem 'trailblazer-rails'

group :development, :test do
  gem 'bullet'
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  gem 'rspec-sidekiq'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'test-prof'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
