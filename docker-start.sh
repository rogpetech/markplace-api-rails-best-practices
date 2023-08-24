#!/bin/bash

# Clean up
echo ">> [$RAILS_ENV] clean up "
rm -rf ./tmp/cache ./tmp/pids ./tmp/sessions ./tmp/sockets

# echo ">> [$RAILS_ENV] bundle exec rake db:create "
bundle exec rake db:drop db:create db:migrate rake db:seed

# echo ">> [$RAILS_ENV] bundle exec rake db:migrate "
# bundle exec rake db:migrate 

# echo ">> [$RAILS_ENV] bundle exec rake db:seed "
# bundle exec rake db:seed 

# echo ">> [$RAILS_ENV] rake searchkick:reindex:all "
# bundle exec rake searchkick:reindex:all

# 
bundle exec rails server -p 3000 -b '0.0.0.0'
