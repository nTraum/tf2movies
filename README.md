# tf2movies

[![Build Status](https://travis-ci.org/nTraum/tf2movies.png)](https://travis-ci.org/nTraum/tf2movies)
[![Coverage Status](https://coveralls.io/repos/nTraum/tf2movies/badge.png?branch=master)](https://coveralls.io/r/nTraum/tf2movies?branch=master)
[![Code Climate](https://codeclimate.com/github/nTraum/tf2movies.png)](https://codeclimate.com/github/nTraum/tf2movies)
[![Dependency Status](https://gemnasium.com/nTraum/tf2movies.png)](https://gemnasium.com/nTraum/tf2movies)

## Requirements

* PostgreSQL (>= 9.1 should be fine)
* Ruby (>= 2.0)
* curl / curl dev libs (tested on 7.35)

## Installation

Environment variables (`.env`):

* [YouTube API](https://cloud.google.com/console/project)
* [Steam API](http://steamcommunity.com/dev)
* [New Relic](http://newrelic.com/)
* Secret Token

`rake tf2movies:check`