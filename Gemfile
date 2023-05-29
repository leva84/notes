source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.3'
gem 'rails', '~> 7.0.5'

gem 'bootsnap', require: false
gem 'bootstrap', '~> 5.2'
gem 'bootstrap5-kaminari-views'
gem 'devise'
gem 'importmap-rails'
gem 'kaminari'
# gem "kredis"
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'redis', '~> 4.0'
gem 'sassc-rails'
gem 'sprockets-rails'
gem 'stimulus-rails'
gem 'turbo-rails'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri mingw x64_mingw]
  gem 'factory_bot', '~> 6.2'
  gem 'faker', '~> 2.19'
  gem 'rspec-rails', '~> 6.0.0'
end

group :development do
  gem 'rubocop'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'selenium-webdriver'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'webdrivers'
end
