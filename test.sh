#!/bin/bash

export PATH=$PATH:$HOME/.rvm/bin
export RAILS_ENV=test
export RACK_ENV=test

rvm use 2.7.7

bin/bundle install
bin/rake assets:precompile
bin/rake db:reset
bin/rake test