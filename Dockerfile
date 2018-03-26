FROM alpine:3.6

MAINTAINER Pierre Prinetti <me@qrawl.net>

RUN apk add --no-cache bash certbot

COPY ./run.sh /run.sh

RUN chmod +x /run.sh

ENTRYPOINT ["/run.sh"]
