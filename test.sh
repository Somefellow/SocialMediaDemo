export RAILS_ENV=test
export RACK_ENV=test

bin/bundle install
bin/rake assets:precompile
rake db:reset
bin/rake test