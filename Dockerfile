FROM alpine:latest

MAINTAINER Pierre Prinetti <me@qrawl.net>

RUN apk add --no-cache certbot

COPY ./run.sh /run.sh

RUN chmod +x /run.sh

CMD ["/run.sh"]
