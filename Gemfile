source 'https://rubygems.org'

ruby '2.3.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.0.0.beta2'

# Database and filestore.
group :development do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3', group: :development
end

group :production do
  # Use PostgreSQL in production
  gem 'pg', group: :production
  gem 'rails_12factor', group: :production
  gem 'aws-sdk', '~> 2', group: :production
end

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# CSS type stuff
gem 'bootstrap-sass', '~> 3.3.6'
gem 'rails_bootstrap_navbar'
# Bootstrap Table for Rails
gem 'bootstrap-table-rails', '~> 1.10.0'
# Fork for Rails 5 support. Consider PRing soon.
gem 'wice_grid', github: 'Gaelan/wice_grid', branch: 'rails5-fix'
gem 'font-awesome-sass', '~> 4.3'

gem 'redcarpet'

# Authentication / Authorization
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'devise', github: 'plataformatec/devise'
gem 'pundit'
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# File management
gem 'paperclip', git: 'git://github.com/thoughtbot/paperclip.git'
gem 'cocoon'
gem 'simple_form'
gem 'high_voltage', '~> 2.4.0', git: 'git://github.com/thoughtbot/high_voltage.git'
gem 'mini_exiftool_vendored'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development, :test do
  # Call 'binding.pry' anywhere in the code to stop execution and get a debugger console
  gem 'pry-byebug'
  gem 'rspec-rails', '3.5.0.beta1'

  gem 'fabrication'
  gem 'ffaker'
  gem 'rails-controller-testing'
end

gem 'pry-rails'
#gem 'rails-footnotes', '~> 4.0'
gem 'rack-mini-profiler'
gem 'flamegraph'
gem 'stackprof'

gem 'raygun4ruby'

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 3.0'

  # Spring speeds up development by keeping your application running in the background.
  # Read more: https://github.com/rails/spring
  gem 'spring'

  gem 'rails-erd'
end
gem 'seedbank'

# Comments
gem 'acts_as_votable', '~> 0.10.0'
