# Dockerfile para Grafana
FROM alpine:3.20.6

# Instale dependências necessárias
RUN apk add --no-cache \
    grafana \
    bash

# Crie o diretório de dados do Grafana
RUN mkdir -p /var/lib/grafana

# Exponha a porta do Grafana
EXPOSE 3000

# Comando para rodar o Grafana
CMD ["grafana-server", "--homepath=/usr/share/grafana", "--config=/etc/grafana/grafana.ini"]