source 'http://rubygems.org'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git', :branch => '3-1-stable'
gem 'rails', '3.1.1'
gem 'pg'
gem 'simple_form'
gem 'carrierwave'
gem 'devise' #, '1.4.9'
gem 'jquery-rails'
gem 'omniauth'
gem "omniauth-facebook"
gem 'heroku'
gem 'execjs'
# gem 'therubyracer-heroku'
gem 'oa-core'
gem "friendly_id", "~> 4.0.0.beta14"
gem 'fog'
gem 'koala'
gem 'carmen'
gem 'geocoder'
gem 'hashie'
gem 'rails3-jquery-autocomplete'
gem 'netrc'
gem "activerecord-import", ">= 0.2.0"
gem 'kaminari'
gem "cancan"

group :production do
	gem 'unicorn'

end
group :devleopment do
  gem 'foreman'
  gem 'mongrel', "~>1.2.0.pre2"
  gem 'thin'
end

# This is outside the test because we need it to run factory girl in the seeds.rb

group :assets do
  gem 'sass-rails', "~> 3.1"
  gem 'coffee-rails', "~> 3.1"
  gem 'uglifier'
end