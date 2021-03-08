# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.2'

gem 'action_policy'
gem 'bootsnap', '>= 1.4.2', require: false
gem 'enumerize'
gem 'interactor'
gem 'money-rails'
gem 'pg'
gem 'puma'
gem 'rails'
gem 'redis-rails'
gem 'rolify'
gem 'sass-rails'
gem 'telegram-bot'

gem 'dry-validation'
gem 'reform'
gem 'reform-rails'
gem 'trailblazer'
gem 'trailblazer-rails'
gem 'trailblazer-developer'

group :development, :test do
  gem 'byebug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot_rails'
  gem 'faker'
  gem 'rspec-rails'
  gem 'rspec-sidekiq'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
end

group :development do
  gem 'listen', '~> 3.2'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
