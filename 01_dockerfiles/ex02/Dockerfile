FROM ruby:latest

RUN apt-get update ; apt-get install -y nodejs
RUN gem install rails

ONBUILD ADD . /opt/app
ONBUILD WORKDIR /opt/app
ONBUILD RUN bundle install
ONBUILD RUN rails db:migrate
ONBUILD RUN rake db:setup
