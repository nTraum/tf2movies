# tf2movies

[![Build Status](https://travis-ci.org/nTraum/tf2movies.png)](https://travis-ci.org/nTraum/tf2movies)
[![Coverage Status](https://coveralls.io/repos/nTraum/tf2movies/badge.png?branch=master)](https://coveralls.io/r/nTraum/tf2movies?branch=master)
[![Code Climate](https://codeclimate.com/github/nTraum/tf2movies.png)](https://codeclimate.com/github/nTraum/tf2movies)
[![Dependency Status](https://gemnasium.com/nTraum/tf2movies.png)](https://gemnasium.com/nTraum/tf2movies)

## Requirements

* PostgreSQL
* Ruby (>= 1.9.3)
* curl / curl dev libs

## Installation

Clone the repository:

`git clone https://github.com/nTraum/tf2movies.git; cd tf2movies`

Make sure Ruby version is 1.9.3 or newer:

`ruby -v`

Install bundler and app dependencies:

`gem install bundler; bundle`

Edit production section of `config/database.yml`:

`vim config/database.yml`

Specify API keys and a random secret token in `.env` files:

`vim .env`

Check if all settings are set:

`rake tf2movies:check`

Create and setup the database

`rake db:create db:migrate db:seed`

Start the web server:

`bundle exec foreman start`

Execute the following 2 commands with your chronical job service of choice (e.g. cron):

`rake tf2movies:check_downloads`
`rake tf2movies:check_movies`

## LICENSE

MIT License.