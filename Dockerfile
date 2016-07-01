FROM ubuntu:xenial

MAINTAINER me@qrawl.net

RUN apt-get update && apt-get install -y letsencrypt

WORKDIR /script

COPY . ./

CMD ["/script/run.sh"]
