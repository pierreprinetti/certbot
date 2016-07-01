FROM ubuntu:xenial

MAINTAINER me@qrawl.net

RUN apt-getupdate && apt-get install -y letsencrypt

WORKDIR /script

COPY . ./

CMD ["run.sh"]
