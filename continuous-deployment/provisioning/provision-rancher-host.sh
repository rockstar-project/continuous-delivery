#!/bin/bash

docker-machine create --driver softlayer \
    --softlayer-user=${SOFTLAYER_USER} \
    --softlayer-api-key=${SOFTLAYER_API_KEY} \
    --softlayer-memory=4096 \
    --softlayer-cpu=2 \
--softlayer-domain=${SOFTLAYER_DOMAIN} \
    --softlayer-region=dal10 \
    rancher-node-2

eval $(docker-machine env rancher-node-2)

docker run -d --restart=unless-stopped -p 80:8080 rancher/server:stable
