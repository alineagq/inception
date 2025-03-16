# Dockerfile para Prometheus
FROM alpine:3.20.5

# Instale dependências necessárias
RUN apk add --no-cache \
    prometheus \
    bash

# Copie o arquivo de configuração do Prometheus
COPY tools/prometheus.yml /etc/prometheus/prometheus.yml

# Exponha a porta do Prometheus
EXPOSE 9090

# Comando para rodar o Prometheus
CMD ["prometheus", "--config.file=/etc/prometheus/prometheus.yml"]