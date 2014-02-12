# tf2movies

[![Build Status](https://travis-ci.org/nTraum/tf2movies.png)](https://travis-ci.org/nTraum/tf2movies)
[![Coverage Status](https://coveralls.io/repos/nTraum/tf2movies/badge.png?branch=master)](https://coveralls.io/r/nTraum/tf2movies?branch=master)
[![Code Climate](https://codeclimate.com/github/nTraum/tf2movies.png)](https://codeclimate.com/github/nTraum/tf2movies)
[![Dependency Status](https://gemnasium.com/nTraum/tf2movies.png)](https://gemnasium.com/nTraum/tf2movies)

## Requirements

* PostgreSQL (>= 9.1 should be fine)
* Ruby (>= 2.0)
* Redis (tested on 2.8.5)
* curl / curl dev libs (tested on 7.35)

## Installation

* [YouTube API](https://cloud.google.com/console/project) key in `/config/initializers/youtube.rb`
* [Steam API](http://steamcommunity.com/dev) key in `config/initializers/omniauth_steam.rb`
* [New Relic](http://newrelic.com/) License key in `config/newrelic.yml`
