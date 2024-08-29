FROM debian:11.10

RUN apt-get update && apt-get install -y nginx openssl

RUN mkdir /etc/nginx/ssl \
    && openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=alinequeiroz@42.fr"

COPY default /etc/nginx/sites-available/.

CMD ["nginx", "-g", "daemon off;"]