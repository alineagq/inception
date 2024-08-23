
FROM alpine:latest

RUN apk update && apk add --no-cache nginx openssl

# Generate SSL certificate
RUN mkdir /etc/nginx/ssl \
    && openssl req -x509 -nodes -days 365 -newkey rsa:2048 \
    -keyout /etc/nginx/ssl/nginx.key \
    -out /etc/nginx/ssl/nginx.crt \
    -subj "/C=US/ST=Denial/L=Springfield/O=Dis/CN=${DOMAIN_NAME}"

COPY conf/nginx.conf /etc/nginx/nginx.conf

CMD ["nginx", "-g", "daemon off;"]
