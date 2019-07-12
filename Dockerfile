FROM python:3

RUN python -m pip install \
	certbot \
	certbot-dns-cloudflare \
	certbot-dns-cloudxns \
	certbot-dns-digitalocean \
	certbot-dns-dnsimple \
	certbot-dns-dnsmadeeasy \
	certbot-dns-google \
	certbot-dns-linode \
	certbot-dns-luadns \
	certbot-dns-nsone \
	certbot-dns-ovh \
	certbot-dns-rfc2136 \
	certbot-dns-route53

ARG BUILD_DATE
ARG VCS_REF
LABEL \
    org.opencontainers.image.created=$BUILD_DATE \
    org.opencontainers.image.authors="https://pierreprinetti.com" \
    org.opencontainers.image.url="https://hub.docker.com/r/pierreprinetti/certbot/" \
    org.opencontainers.image.source="https://github.com/pierreprinetti/certbot" \
    org.opencontainers.image.version=$VCS_REF \
    org.opencontainers.image.revision=$VCS_REF \
    org.opencontainers.image.title="certbot" \
    org.opencontainers.image.description="Dockerized Certbot: EFF's Let's encrypt ACME client"

ENTRYPOINT ["certbot"]
