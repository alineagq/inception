FROM alpine:3.19.4

RUN apk update && \
    apk upgrade && \
    apk add php82 \
            php82-fpm \
            php82-mysqli \
            php82-json \
            php82-xml \
            php82-curl \
            php82-openssl \
            php82-mbstring \
            php82-gd \
            php82-zlib \
            php82-phar \
            mysql-client \
            curl

RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar

RUN chmod +x wp-cli.phar

RUN mv wp-cli.phar /usr/local/bin/wp

WORKDIR /var/www/wordpress

RUN wp core download --path=/var/www/wordpress

COPY tools/start_wordpress.sh /usr/bin/start_wordpress.sh

RUN chmod +x /usr/bin/start_wordpress.sh

RUN mkdir -p /run/php

EXPOSE 9000

RUN echo "listen = 0.0.0.0:9000" >> /etc/php82/php-fpm.d/www.conf

ENTRYPOINT [ "/usr/bin/start_wordpress.sh" ]