FROM nginx

MAINTAINER Paul Liljenberg "liljenberg.paul@gmail.com"

# Install the whois package which contains mkpaswd for crypt
# to be used with password protected directories.
RUN apt-get update && apt-get -y install apache2-utils

ENV PASSWORD password
ENV USER user
ADD nginx.conf /etc/nginx/nginx.conf

ADD setup.sh /setup.sh
VOLUME ["/usr/local/nginx/html"]

EXPOSE 80

ENTRYPOINT ["/setup.sh"]
