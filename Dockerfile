FROM ruby:2.2
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
RUN mkdir /superabc
WORKDIR /superabc
COPY Gemfile /superabc/Gemfile
COPY Gemfile.lock /superabc/Gemfile.lock
RUN bundle install
COPY . /superabc
RUN rake db:schema:load
