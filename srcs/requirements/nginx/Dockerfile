FROM alpine:3.22

RUN apk update && apk add --no-cache bash \
    nginx \
    openssl

RUN mkdir -p /etc/nginx/ssl /var/www/html /run/nginx
RUN rm -f /etc/nginx/conf.d/default.conf
COPY conf/default.conf /etc/nginx/http.d/default.conf
COPY certs /etc/nginx/certs
COPY script.sh /script.sh

RUN chmod +x /script.sh

EXPOSE 443

ENTRYPOINT ["/script.sh"]
