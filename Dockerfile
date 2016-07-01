FROM alpine:latest

MAINTAINER me@qrawl.net

RUN apt-get update && apt-get install -y letsencrypt

COPY ./run.sh /run.sh

RUN chmod +x /run.sh

CMD ["/run.sh"]
