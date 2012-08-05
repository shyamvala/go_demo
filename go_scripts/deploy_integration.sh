#! /bin/bash

source "$HOME/.rvm/scripts/rvm" &&
rvm use 1.9.3@go_demo
bundle exec rake deploy:integration
