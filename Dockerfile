FROM ruby:2.6.0

RUN apt-get update && apt-get install -y \
  build-essential \
  nodejs

# Configure bundler and PATH
ENV LANG=C.UTF-8 \
  GEM_HOME=/bundle
ENV BUNDLE_PATH $GEM_HOME
ENV BUNDLE_APP_CONFIG=$BUNDLE_PATH \
  BUNDLE_BIN=$BUNDLE_PATH/bin
ENV PATH /myapp/bin:$BUNDLE_BIN:$PATH

RUN mkdir -p /myapp
WORKDIR /myapp

ADD Gemfile Gemfile.lock ./
ADD . ./

RUN gem update --system
RUN gem install bundler && bundle install --jobs 20 --retry 5

#COPY docker-entrypoint.sh /usr/bin/
#RUN chmod +x /usr/bin/docker-entrypoint.sh
#ENTRYPOINT ["docker-entrypoint.sh"]

EXPOSE 3001

# Start the main process.
# CMD ["rails", "server", "-b", "0.0.0.0"]