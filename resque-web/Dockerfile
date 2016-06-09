FROM ruby:2.2.3

COPY ./ /opt/resque-web

WORKDIR /opt/resque-web

EXPOSE 9292

RUN chmod uga+x run
RUN gem install bundler
RUN bundle install

ENTRYPOINT ["/opt/resque-web/run"]
CMD ["--help"]