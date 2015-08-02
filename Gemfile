source "https://rubygems.org"

gem "rails", "~> 4.0.0"
gem "pg"
gem "sass-rails", "~> 4.0.0", ">= 4.0.2"
gem "uglifier"
gem "coffee-rails"
gem "therubyracer", require: "v8"
gem "jquery-rails"

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem "sdoc", require: false
end

gem "dotenv-rails"
gem "slim-rails"
gem "bootstrap-sass"
gem "omniauth-steam"
gem "font-awesome-rails"
gem "youtube_it"
gem "gretel"
gem "rails_autolink"
gem "cocoon"
gem "pundit"
gem "kaminari"
gem "curb"
gem "puma"
gem "colored"
gem "friendly_id"
gem "simple_enum"
gem "whenever",               require: false
gem "sanitize"
gem "rails-timeago"
gem "rack-google-analytics"
gem "pg_search"
gem "pry-rails"
gem "rack-mini-profiler" # must be placed below pg gem to show SQL queries
gem "flamegraph"

group :production do
  gem "dalli"
  gem "connection_pool"
  gem "sentry-raven"
end

group :development, :test do
  gem "coveralls", require: false
  gem "database_cleaner"
  gem "did_you_mean"
  gem "factory_girl_rails"
  gem "rspec-rails", "~> 3.0"
  gem "rubocop"
  gem "rubocop-rspec"
  gem "webmock"
end

group :development do
  gem "lol_dba"
  gem "annotate"
  gem "better_errors"
  gem "binding_of_caller"
  gem "meta_request"
  gem "pry-nav"
  gem "quiet_assets"
  gem "rails-footnotes"

  # deployment
  gem "capistrano-rails",           require: false
  gem "capistrano-rbenv",           require: false
  gem "capistrano3-puma",           require: false
end
