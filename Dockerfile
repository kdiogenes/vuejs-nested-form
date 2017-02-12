FROM ruby:2.3.3-alpine
RUN apk update && apk add --no-cache build-base postgresql-dev nodejs git tzdata
RUN mkdir /myapp
WORKDIR /myapp
ADD Gemfile /myapp/Gemfile
ADD Gemfile.lock /myapp/Gemfile.lock
ADD vendor /myapp/vendor
RUN bundle install --jobs 20 --retry 5
ADD . /myapp
RUN /usr/sbin/adduser -D -u ${USER_ID:-1000} myuser
