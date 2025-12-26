# Nginx Env Proxy (Railway-friendly)

A tiny Nginx image that proxies **all** incoming HTTP traffic to an upstream host/port configured **only via environment variables**. Designed to work nicely on Railway where the listening port is typically provided as `PORT`.

## What it does

- Listens on `PORT` (Railway) or `LISTEN_PORT`
- Proxies `/*` to `http://UPSTREAM_HOST:UPSTREAM_PORT`
- Includes common reverse-proxy headers + WebSocket upgrade support
- Exposes a simple health endpoint: `GET /healthz`

---

## Environment variables

### Required (practically)
- `UPSTREAM_HOST` — upstream hostname or service DNS name  
  Example: `my-php-fpm.railway.internal`
- `UPSTREAM_PORT` — upstream port  
  Example: `9000`

### Listening port
- `PORT` — Railway default listening port (preferred on Railway)
- `LISTEN_PORT` — overrides `PORT` if set

### Optional
- `SERVER_NAME` (default: `_`)
- `CLIENT_MAX_BODY_SIZE` (default: `50m`)
- `PROXY_CONNECT_TIMEOUT` (default: `60s`)
- `PROXY_SEND_TIMEOUT` (default: `60s`)
- `PROXY_READ_TIMEOUT` (default: `60s`)

---

## Railway setup

1. Create a new service from this repository.
2. Set environment variables in the service:
   - `UPSTREAM_HOST=my-php-fpm.railway.internal`
   - `UPSTREAM_PORT=9000`
3. Deploy.

Railway will automatically set `PORT`. This container will listen on it.

---

## Local run

```bash
docker build -t nginx-env-proxy .
docker run --rm -p 8080:8080 \
  -e LISTEN_PORT=8080 \
  -e UPSTREAM_HOST=host.docker.internal \
  -e UPSTREAM_PORT=9000 \
  nginx-env-proxy
