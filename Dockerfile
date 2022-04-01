FROM ruby:3.1.1-slim-buster

LABEL MAINTAINER Diogo Caetano <diogo.caetano.alves@gmail.com>
# Last update 03/2022

# Install essential Linux packages
RUN apt-get clean
RUN apt-get update
RUN apt-get install -y git-all
RUN apt-get install -y build-essential
RUN apt-get install -y libpq-dev libnotify-bin xosd-bin nano curl wget unzip

# Chrome
# This is a complete list of versions https://www.ubuntuupdates.org/package/google_chrome/stable/main/base/google-chrome-stable
ARG CHROME_VERSION="99.0.4844.84-1"
RUN wget https://dl.google.com/linux/chrome/deb/pool/main/g/google-chrome-stable/google-chrome-stable_${CHROME_VERSION}_amd64.deb
RUN dpkg -i google-chrome-stable_${CHROME_VERSION}_amd64.deb; apt-get -fy install
# Chrome Driver list of versions https://chromedriver.chromium.org/downloads
ARG CHROME_DRIVER_VERSION="99.0.4844.51"
RUN wget https://chromedriver.storage.googleapis.com/${CHROME_DRIVER_VERSION}/chromedriver_linux64.zip
RUN unzip chromedriver_linux64.zip
RUN mv chromedriver /usr/bin/chromedriver
RUN chown root:root /usr/bin/chromedriver
RUN chmod +x /usr/bin/chromedriver

# install posgtres client
ARG POSTGRESQL_VERSION="14"
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ buster-pgdg main" > /etc/apt/sources.list.d/pgdg.list
RUN wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add -
RUN apt-get update -qq
RUN apt install -y postgresql-client-${POSTGRESQL_VERSION}

# Install image upload dependences
RUN apt-get install -y imagemagick graphviz file

#certificados openssl
RUN apt-get install -y openssl ca-certificates

# Define where our application will live inside the image
ENV RAILS_ROOT /var/www/myapp
# Create application home. App server will need the pids dir so just create everything in one shot
RUN mkdir -p $RAILS_ROOT/tmp/pids
# Set our working directory inside the image
WORKDIR $RAILS_ROOT

# Expose port 3000 to the Docker host, so we can access it, on dokku the nginx map this port
# from the outside.
EXPOSE 80
EXPOSE 7658
EXPOSE 3000

# Possible to run the nano command
ENV TERM xterm
# Allow unicode characters in the console
ENV LANG C.UTF-8

# Set volume path to cache bundler
ENV BUNDLE_PATH /bundle/vendor
# update ruby gem system
RUN gem update --system
# Prevent bundler warnings; ensure that the bundler version executed is >= that which created Gemfile.lock
RUN gem install bundler
# Use the Gemfiles as Docker cache markers. Always bundle before copying app src.
# (the src likely changed and we don't want to invalidate Docker's cache too early)
# http://ilikestuffblog.com/2014/01/06/how-to-skip-bundle-install-when-deploying-a-rails-app-to-docker/
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install

# Copy the Rails application into place
COPY . .

# add rails bin folder to path this avoid to use 'bundle exec'
ENV PATH="${RAILS_ROOT}/bin:${PATH}"

RUN echo $PATH

# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default.
CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
# CMD [ "config/containers/app_cmd.sh" ]

# Command to acess de container
# docker exec -it railsbase_app_1 /bin/bash