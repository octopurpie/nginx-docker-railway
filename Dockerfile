FROM nginx:1.27-alpine

# envsubst для подстановки переменных в шаблон
RUN apk add --no-cache gettext

# Шаблон конфига + entrypoint
COPY default.conf.template /etc/nginx/templates/default.conf.template
COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

# Railway обычно ожидает, что процесс слушает $PORT
ENV PORT=8080

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
