FROM    alpine:3.19.4

RUN apk update && \
    apk upgrade && \
    apk add	nginx \
              openssl

RUN mkdir -p etc/nginx/ssl

RUN openssl req -newkey rsa:4096 -x509 -sha256 -days 365 -nodes \
       -out /etc/nginx/ssl/aqueiroz.crt \
       -keyout /etc/nginx/ssl/aqueiroz.key \
       -subj "/C=FR/ST=Paris/L=Paris/O=42 School/OU=aqueiroz/CN=aqueiroz/"

COPY conf/nginx.conf /etc/nginx/nginx.conf

CMD [ "nginx", "-g", "daemon off;" ]