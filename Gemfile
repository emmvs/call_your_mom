source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

# Core Rails dependencies
gem 'rails', '~> 7.0.8'
gem 'pg', '~> 1.1' # Database
gem 'puma', '~> 5.0' # Web Server [https://github.com/puma/puma]
gem 'sprockets-rails' # Sprockets f/ Asset Pipeline [https://github.com/rails/sprockets-rails]

# Hotwire
gem 'turbo-rails' # [https://turbo.hotwired.dev]
gem 'stimulus-rails' # JS Framework [https://stimulus.hotwired.dev]

# JavaScript w/o Webpack
gem 'importmap-rails' # Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]

# Stylesheets
gem 'sass-rails' # Sass for stylesheets w/ Rails

# Front End Tools & Styles
gem 'bootstrap', '~> 5.2'
gem 'autoprefixer-rails'
gem 'font-awesome-sass', '~> 6.1'
gem 'simple_form', github: 'heartcombo/simple_form'

# Authentication and security
gem 'bcrypt', '~> 3.1.7' # Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
gem 'devise' # Comprehensive authentication solution

# Performance & Optimization
gem 'tzinfo-data', platforms: %i[ mingw mswin x64_mingw jruby ] # Timezone data for Windows
gem 'bootsnap', require: false # Reduces boot times through caching; required in config/boot.rb

group :development, :test do
  gem 'rspec-rails'
  gem 'debug', platforms: %i[ mri mingw x64_mingw ]
  gem 'dotenv-rails'
  gem 'faker'
end

group :development do
  gem 'web-console' # Use console on exceptions pages [https://github.com/rails/web-console]
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem 'factory_bot_rails'
  gem 'shoulda-matchers', '~> 6.0'
  gem 'capybara'
  gem 'selenium-webdriver'
end

# Uncomment the following gems as needed:
# gem 'jbuilder' # For JSON API builder [https://github.com/rails/jbuilder]
# gem 'redis', '~> 4.0' # Redis for ActionCable (in production)
# gem 'kredis' # Enhanced Redis for Rails [https://github.com/rails/kredis]
# gem 'image_processing', '~> 1.2' # Image processing for ActiveStorage
# gem 'rack-mini-profiler' # Performance profiling [https://github.com/MiniProfiler/rack-mini-profiler]
# gem 'spring' # Preloader for faster dev env [https://github.com/rails/spring]
