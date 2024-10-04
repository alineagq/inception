# Dockerfile
FROM debian:11.10

# Instalar dependências
RUN apt-get update && apt-get install -y \
    curl \
    gnupg2 \
    python3 \
    python3-pip \
    && rm -rf /var/lib/apt/lists/*

# Adicionar a chave do Datadog e o repositório
RUN DD_API_KEY=<datadog_key> \
DD_SITE="us5.datadoghq.com" \
bash -c "$(curl -L https://install.datadoghq.com/scripts/install_script_agent7.sh)"

# Copiar arquivo de configuração do Datadog
COPY datadog.yaml /etc/datadog-agent/datadog.yaml

# Definir variáveis de ambiente
ENV DD_API_KEY=<datadog_key>
ENV DD_ENV=production

# Expor a porta do APM (se estiver habilitado)
EXPOSE 8126

# Comando para iniciar o Agent e a aplicação
CMD ["sh", "-c", "service datadog-agent start && python3 app.py"]
