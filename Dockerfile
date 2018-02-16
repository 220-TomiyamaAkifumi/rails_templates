FROM ruby:2.5.0

ENV myapp /usr/src/myapp
RUN mkdir $myapp
WORKDIR $myapp

RUN apt-get update -qq && \
    apt-get install -y build-essential libpq-dev nodejs

ADD Gemfile* $myapp

RUN \
  echo 'gem: -N' >> ~/.gemrc && \
  cp ~/.gemrc /etc/gemrc && \
  chmod uog-r /etc/gemrc && \
  bundle config --global build.nokogiri --use-system-libraries && \
  bundle config --global jobs 4 && \
  bundle install && \
  rm -rf ~/.gem

COPY . $myapp
