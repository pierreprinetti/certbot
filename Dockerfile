FROM alpine:3.8

RUN apk add --no-cache bash certbot

COPY ./run.sh /run.sh

RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]
