source 'https://rubygems.org'

gem 'rails', '4.2.0'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

gem 'ransack'
gem 'slim-rails'
gem 'chartkick'
gem 'httparty'
gem 'groupdate'
gem 'active_median'
gem 'whenever', :require => false
gem 'gon'

group :production do
  gem 'unicorn'
end

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug'
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console', '~> 2.0'
  gem 'rspec-rails'
  gem 'capistrano-rails'
  gem 'capistrano-bundler'
  gem 'capistrano-rbenv'
  gem 'capistrano3-unicorn'
  gem 'spring'
  gem 'quiet_assets'
end

source 'https://rails-assets.org' do
  gem 'rails-assets-highcharts', '4.0.4'
  gem 'rails-assets-leaflet'
  gem 'rails-assets-lodash'
  gem 'rails-assets-leaflet.markercluster'
end
