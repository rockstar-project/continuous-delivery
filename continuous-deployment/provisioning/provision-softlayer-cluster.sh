#!/bin/bash

HOW_MANY=5

for (( instance=$HOW_MANY; $instance > 1; instance=$instance - 1 )); do
    docker-machine create --driver softlayer --softlayer-user=${SOFTLAYER_USER} --softlayer-api-key=${SOFTLAYER_API_KEY} --softlayer-domain=sldev.us --softlayer-region=dal05 kickster-node-${instance}
done

# To provision using softlayer cli
#slcli vs create --hostname=kickster-basecamp-0 --domain=sldev.us --cpu 2 --memory 1024 -o UBUNTU_14_64 --datacenter=dal05 --billing=hourly

docker-machine create --driver softlayer --softlayer-user=${SOFTLAYER_USER} --softlayer-api-key=${SOFTLAYER_API_KEY} --softlayer-domain=${SOFTLAYER_DOMAIN} --softlayer-region=dal10 --softlayer-memory 32 --softlayer-cpu 8 kickster-node-4
docker-machine create --driver softlayer --softlayer-user=${SOFTLAYER_USER} --softlayer-api-key=${SOFTLAYER_API_KEY} --softlayer-domain=${SOFTLAYER_DOMAIN} --softlayer-region=dal10 --softlayer-memory 32 --softlayer-cpu 8 kickster-node-5
docker-machine create --driver softlayer --softlayer-user=${SOFTLAYER_USER} --softlayer-api-key=${SOFTLAYER_API_KEY} --softlayer-domain=${SOFTLAYER_DOMAIN} --softlayer-region=dal10 --softlayer-memory 32 --softlayer-cpu 8 kickster-node-6
docker-machine create --driver softlayer --softlayer-user=${SOFTLAYER_USER} --softlayer-api-key=${SOFTLAYER_API_KEY} --softlayer-domain=${SOFTLAYER_DOMAIN} --softlayer-region=dal10 --softlayer-memory 32 --softlayer-cpu 8 rancher-node-3


http://rancher.bluemixcloud.us/v1-webhooks/endpoint?key=9W9ZNrWL8Ts7F3amIxPMsK41cydpzXS688We4h1n&projectId=1a7