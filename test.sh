#!/bin/bash

export RAILS_ENV=test
export RACK_ENV=test

bin/bundle install
bin/rake assets:precompile
bin/rake db:reset
bin/rake test