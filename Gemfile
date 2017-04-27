source 'https://rubygems.org'


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.5'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'materialize-sass'

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'
# Commented out classic turbolinks gem in favor of the jquery-turbolinks because of compatability issues with Materialize.
# Read more: https://github.com/mkhairi/materialize-sass 
gem 'jquery-turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Highcharts allows easy creation of simple charts
gem 'highcharts-rails'
# Lodash (built on top of underscore.js) is a great js library 
# that has tons of helper functions to manipulate objects, arrays, etc.
gem 'lodash-rails'

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# For populator rake task
gem 'faker'
gem 'populator3'

# For .csv, .xls, .xlsx import and export
gem "roo", "~> 2.7.0"
# Special gem for specifically xls files
gem 'roo-xls'
# With importing a lot of Excel data (more than 4kb) we need to store data somewhere else besides
# the cookie. The error is: ActionDispatch::Cookies::CookieOverflow. So we need to use this gem to
# store sessions in the db.
gem 'activerecord-session_store'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
end

group :development do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'

  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

# Gems used only in testing
group :test do
  gem 'factory_girl_rails'
  gem 'shoulda'
  gem 'shoulda-matchers'
  gem 'minitest', '5.8.4'
  gem 'minitest-rails', '2.2.0'
  gem 'minitest-reporters', '1.1.7'
  gem 'simplecov'
  gem 'single_test'
end

group :production do
  gem 'pg'
end
