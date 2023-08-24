FROM ruby:3.2.0

ENV RAILS_ROOT /var/www/app
ENV RAILS_ENV 'development'
ENV RACK_ENV 'development'


RUN mkdir -p $RAILS_ROOT
WORKDIR $RAILS_ROOT

RUN apt-get update -qq && apt-get install -y nodejs npm postgresql-client
COPY Gemfile Gemfile.lock ./
RUN gem install bundler -v 2.4.1
RUN bundle install
COPY . .

# Expose the port the app runs on
EXPOSE 3000
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
