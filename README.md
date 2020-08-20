# certbot

Containerized [certbot][certbot] with the plugins listed [in the docs][dns-plugins] made available:

* certbot-dns-cloudflare
* certbot-dns-cloudxns
* certbot-dns-digitalocean
* certbot-dns-dnsimple
* certbot-dns-dnsmadeeasy
* certbot-dns-google
* certbot-dns-linode
* certbot-dns-luadns
* certbot-dns-nsone
* certbot-dns-ovh
* certbot-dns-rfc2136
* certbot-dns-route53

## Obtaining certificates

The container entrypoint is literally EFF's `certbot`. All the flags and
arguments described in the documentation will work here.

## Example: Manual dns-01 challenge

The examples use Podman. Substitute [`podman`][podman] with `docker` if you prefer that.

The expected outcome is to have the certificates saved in a volume, so that it can be easily mounted into the webserver container:

```
podman volume create --name https-certs
```

Prepare to manually edit your DNS zone with the provided instructions:

```
podman run --rm -it \
	-v https-certs:/etc/letsencrypt \
	quay.io/pierreprinetti/certbot certonly \
		--manual \
		--preferred-challenges=dns \
		-m me@example.com \
		--agree-tos \
		-d example.com \
		-d www.example.com
```

### Example: Obtaining certificates with the OVH DNS plugin

In this example, my OVH credentials are stored in the file `./ovh.ini` as described in [the docs][dns-ovh-docs].

This command will persist the Letsencrypt material, including the HTTPS certificate, in the newly created volume:

```
podman run --rm \
	-v $(pwd)/ovh.ini:/ovh.ini:ro \
	-v https-certs:/etc/letsencrypt \
	quay.io/pierreprinetti/certbot certonly \
		--non-interactive \
		--agree-tos \
		-m me@example.com \
		--dns-ovh \
		--dns-ovh-credentials /ovh.ini \
		-d example.com \
		-d www.example.com
```

Remember to substitute `me@example.com` with your own email address in order to receive important notifications about your certificate.

This same command will renew the certificates, if they are found in the attached volume.

## Use the certs in the server

Spin your favorite reverse proxy with something like:

```
podman run \
	--name some-nginx \
	-v https-certs:/etc/nginx/certs:ro \
	-p 80:80 \
	-p 443:443 \
	--restart unless-stopped \
	-d nginx:mainline-alpine
```

Example configuration for `example.com` in your containerized nginx:

```
server {
	listen      443 http2;
	listen      [::]:443 http2;
	server_name example.com;

	ssl on;
	ssl_certificate     /etc/nginx/certs/live/example.com/fullchain.pem;
	ssl_certificate_key /etc/nginx/certs/live/example.com/privkey.pem;

	[...]
```

[certbot]: https://certbot.eff.org/ "Certbot website"
[dns-plugins]: https://certbot.eff.org/docs/using.html#dns-plugins "Certbot DNS plugins"
[podman]: https://podman.io/ "podman.io"
[dns-ovh-docs]: https://certbot-dns-ovh.readthedocs.io/en/stable "Certbot DNS OVH plugin documentation"
