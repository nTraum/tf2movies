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

### Cloning repository

`git clone https://github.com/nTraum/tf2movies.git; cd tf2movies`

### Checking Ruby version
Must be 1.9.3 or newer.

`ruby -v`

### Install bundler and app dependencies

`gem install bundler; bundle`

### Database settings
Edit production section of `config/database.yml` to fit your needs.

`vim config/database.yml`

### App settings
You need to configure the following environment variables to run tf2movies:

* `YOUTUBE_API_KEY` - API key for [YouTube](https://cloud.google.com/console/project)
* `STEAM_API_KEY` - API key for [Steam API/Omniauth](http://steamcommunity.com/dev)
* `NEWRELIC_API_KEY` - API key for [New Relic](http://newrelic.com/) app monitoring (optional)
* `SECRET_TOKEN` - Rails' [secret token](http://guides.rubyonrails.org/security.html#session-storage) for session storage

Use the `.env` file to set these environment variables. The command `rake secret` can be used to generate a custom secret token for you.

`vim .env`

### Check app settings

`rake tf2movies:check`

### Create & setup database

`rake db:create db:migrate db:seed`

### Start the web server

`bundle exec foreman start`

### Set up recurring jobs

Tf2movies will refresh movie meta data (views, title...) and the availability of downloads for you. Configure your favourite job scheduler (cron?) to execute the following commands periodically:

`rake tf2movies:check_downloads`

`rake tf2movies:check_movies`

The execution of one command will refresh one entity. How often those jobs run is up to you and may depend on your amount of movies/downloads.

### Become an admin

Login via Steam, then run:

`rake tf2movies:adminify[YOUR_STEAM_NICK]`

where `YOUR_STEAM_NICK` is your Steam nickname.

## LICENSE

MIT License.
