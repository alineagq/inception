
## The difference between a Docker image used with docker compose and without docker compose

- Sem: tem que rodar todos os comando pra configurar as imagens, um por um. Ex:

docker run -it -rm alpine sh
apk add nginx

-Com:
Já configura tudo com apenas um comando. Ex:

docker compose up -d

## The benefit of Docker compared to VMs