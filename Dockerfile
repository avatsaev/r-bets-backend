FROM ruby:2.3-slim

MAINTAINER Aslan Vatsaev (@avatsaev)

RUN apt-get update && apt-get install -qq -y --no-install-recommends \
      build-essential nodejs libpq-dev

ENV INSTALL_PATH /r_bets_backend
RUN mkdir -p $INSTALL_PATH

WORKDIR $INSTALL_PATH
COPY Gemfile Gemfile.lock ./
RUN bundle install --binstubs
COPY . .

#RUN bundle exec rake RAILS_ENV=production DATABASE_URL=postgresql://user:pass@127.0.0.1/dbname ACTION_CABLE_ALLOWED_REQUEST_ORIGINS=foo,bar SECRET_TOKEN=dummytoken assets:precompile
VOLUME ["$INSTALL_PATH/public"]

CMD puma -C config/puma.rb