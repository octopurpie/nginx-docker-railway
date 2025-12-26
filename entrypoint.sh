#!/bin/sh
set -eu

# Значения по умолчанию
: "${PORT:=8080}"
: "${UPSTREAM_HOST:=127.0.0.1}"
: "${UPSTREAM_PORT:=9000}"
: "${SERVER_NAME:=_}"
: "${CLIENT_MAX_BODY_SIZE:=50m}"
: "${PROXY_READ_TIMEOUT:=300}"
: "${PROXY_SEND_TIMEOUT:=300}"
: "${PROXY_CONNECT_TIMEOUT:=30}"

export PORT UPSTREAM_HOST UPSTREAM_PORT SERVER_NAME \
  CLIENT_MAX_BODY_SIZE PROXY_READ_TIMEOUT PROXY_SEND_TIMEOUT PROXY_CONNECT_TIMEOUT

# Подставляем env в шаблон
envsubst '${PORT} ${UPSTREAM_HOST} ${UPSTREAM_PORT} ${SERVER_NAME} ${CLIENT_MAX_BODY_SIZE} ${PROXY_READ_TIMEOUT} ${PROXY_SEND_TIMEOUT} ${PROXY_CONNECT_TIMEOUT}' \
  < /etc/nginx/templates/default.conf.template \
  > /etc/nginx/conf.d/default.conf

exec "$@"
