FROM ruby:2.5

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev curl
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash -
RUN apt-get install -y nodejs

RUN mkdir /myapp

WORKDIR /myapp

COPY Gemfile /myapp/Gemfile
RUN bundle install

COPY . /myapp
