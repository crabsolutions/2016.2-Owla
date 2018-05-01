source 'https://rubygems.org'
ruby '2.4.4'

gem 'simple_form', '~> 4.0'
gem 'jquery-minicolors-rails', '~> 2.2.6.1'
# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'
# Use postgres as the database for Active Record
gem 'pg', '~> 1.0.0'
# Use Puma as the app server
gem 'puma', '~> 3.11.4'
# Gem to get instances variables in test
gem 'rails-controller-testing', '~> 1.0.2'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0.7'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '~> 4.1.10'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2.2'
# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby
#Gem thats secures password
gem 'bcrypt', '~> 3.1.11'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 4.0.1'
# Paperclip for profile image and file upload for questions and answers
gem 'paperclip', '~> 6.0'
# Gem to convert PDF files to JPG files
gem 'rmagick', '~> 2.16'
# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Text editor
gem 'bootstrap-wysihtml5-rails', '~> 0.3.3.8'

# Boosttrap switch
gem 'bootstrap-switch-rails', '~> 3.3.3'

gem "codeclimate-test-reporter", group: :test, require: nil
gem 'acts_as_votable', '~> 0.11.1'

group :cucumber do
  gem 'capybara',               '~> 3.0.3'
  gem 'cucumber-rails',         '~> 1.6.0'
  gem 'database_cleaner',       '~> 1.7.0'
  gem 'selenium-webdriver',     '>= 3.11'
  gem 'chromedriver-helper' if ENV['SELENIUM_DRIVER'] == 'chrome'
  gem 'geckodriver-helper' if ENV['SELENIUM_DRIVER'] == 'firefox'
end

source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap-rtl'
  gem 'rails-assets-jquery-knob'
  gem 'rails-assets-bootstrap-daterangepicker'
  gem 'rails-assets-jquery-sparkline'
  gem 'rails-assets-jquery-icheck'
  gem 'rails-assets-admin-lte'
end

gem 'admin_lte-rails'
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
gem 'jquery-turbolinks'
gem 'responders'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platform: :mri
  gem 'simplecov', :require => false
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> anywhere in the code.
  gem 'web-console'
  gem 'listen', '~> 3.0.5'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
