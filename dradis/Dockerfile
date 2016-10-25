FROM ruby:1.9.3

RUN git clone --depth=1 https://github.com/dradis/dradisframework.git

WORKDIR /dradisframework

RUN bundle install \
    && cd bin && ruby ./setup
    
