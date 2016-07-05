# certbot
Dockerized [certbot][certbot].

## Obtaining certificates

The container will run certbot against all the domains provided with the environment variable `domains`.

If `-e distinct=true` is passed, certbot will be run separately for every listed domain.

```
docker volume create --name nginx-certs

# docker stop nginx

docker run \
  -v nginx-certs:/etc/letsencrypt \
  -e http_proxy=$http_proxy \
  -e domains="example.com,example.org" \
  -e email="me@example.com" \
  -p 80:80 \
  -p 443:443 \
  --rm pierreprinetti/certbot:latest

# docker start nginx
```

## Renewing certificates

```
webserver_container=nginx # change as appropriate

docker pull pierreprinetti/certbot:latest

webserver_is_running=$(docker inspect -f {{.State.Running}} $webserver_container)

if $webserver_is_running; then docker stop $webserver_container; fi

docker run \
  -v nginx-certs:/etc/letsencrypt \
  -e http_proxy=$http_proxy \
  -e renew=true \
  -p 80:80 \
  -p 443:443 \
  --rm pierreprinetti/certbot:latest

if $webserver_is_running; then docker start $webserver_container; fi
```

## With dockerized nginx

Spin your favorite reverse proxy with something like:

```
docker run \
  --name some-nginx \
  -v nginx-certs:/etc/nginx/certs:ro \
  -p 80:80 \
  -p 443:443 \
  --restart unless-stopped \
  -d nginx:mainline-alpine
```

Example configuration for `example.com` in your dockerized nginX:

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

[certbot]: https://certbot.eff.org/ "letsencrypt client website"
