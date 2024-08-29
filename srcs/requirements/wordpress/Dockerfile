FROM debian:11.10

RUN apt-get update && apt-get install -y php-fpm php-mysql curl

RUN mkdir -p /run/php && chown -R www-data:www-data /run/php

COPY www.conf /etc/php/7.4/fpm/pool.d/.
COPY script.sh .

RUN chmod +x script.sh

ENTRYPOINT ["./script.sh"]