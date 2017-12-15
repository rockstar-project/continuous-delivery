#!/bin/bash

export RANCHER_PORT=8080
export RANCHER_AGENT_VERSION=v1.2.0
export RANCHER_CLI_VERSION=v0.4.1

#rancher --url http://dataprotect-rancher.sldev.us:8080/v1 --access-key 49FFC53392F793695251 --secret-key RTr3Pc4GspyQFoFBpfYpmZk3hqrGwTVtBHC2jXkT env

echo "installing rancher cli"
curl -SLO https://releases.rancher.com/cli/$RANCHER_CLI_VERSION/rancher-darwin-amd64-$RANCHER_CLI_VERSION.tar.gz > /dev/null 2>&1
tar -xzf rancher-darwin-amd64-$RANCHER_CLI_VERSION.tar.gz
mv rancher-$RANCHER_CLI_VERSION/rancher rancher
rm rancher-darwin-amd64-$RANCHER_CLI_VERSION.tar.gz
rm -rf rancher-$RANCHER_CLI_VERSION

echo "creating rancher virtual machine instance"
docker-machine create --driver virtualbox rancher-vm > /dev/null 2>&1
export RANCHER_HOST=$(docker-machine ip rancher-vm)

echo "installing rancher service"
eval $(docker-machine env rancher-vm)
docker run -d --restart=unless-stopped -p $RANCHER_PORT:$RANCHER_PORT rancher/server > /dev/null 2>&1

echo "Waiting for rancher service to launch on port $RANCHER_PORT"
attempt=0
rancher_attempt=0
while ! nc -z $RANCHER_HOST $RANCHER_PORT; do
    attemp='expr $rancher_attempt + 1'
    if [ $rancher_attempt -ge 120 ]
    then
        break
    fi
    sleep 0.5
done
echo "rancher service is up on $RANCHER_PORT"

echo "configuring rancher environment"
export RANCHER_ENVIRONMENT=dev
export RANCHER_URL=http://$RANCHER_HOST:$RANCHER_PORT/v2-beta
export RANCHER_API_KEYS_JSON=$(curl -X POST --silent $RANCHER_URL/apikeys | jq -r '. | {accessKey: .publicValue, secretKey: .secretValue}')
export RANCHER_ACCESS_KEY=($(echo $RANCHER_API_KEYS_JSON | jq -r .accessKey))
export RANCHER_SECRET_KEY=($(echo $RANCHER_API_KEYS_JSON | jq -r .secretKey))
export RANCHER_PROJECT_ID=$(./rancher --url $RANCHER_URL --access-key $RANCHER_ACCESS_KEY --secret-key $RANCHER_SECRET_KEY env create -t kubernetes $RANCHER_ENVIRONMENT)

echo "rancher-url: $RANCHER_URL"
echo "access-key: $RANCHER_ACCESS_KEY"
echo "secret-key: $RANCHER_SECRET_KEY"
echo "environment: $RANCHER_PROJECT_ID"

REGISTRY_ID=$(curl -u $RANCHER_ACCESS_KEY:$RANCHER_SECRET_KEY --silent -X POST -H 'Content-Type: application/json' -d '{"description": "JFrog Artifactory supported by ibm whitewater team", "name": "jfrog-artifactory", "serverAddress": "storage-dataprotect-api-docker.artifactory.swg-devops.com"}' $RANCHER_URL/projects/$RANCHER_PROJECT_ID/registries | jq -r .id)
REQUEST_BODY=$(jq -n --arg registryId "$REGISTRY_ID" '{"description": "jfrog artifactory credentials","email": "ssiddiq@us.ibm.com","name": "Sal Siddiqui","publicValue": $DOCKER_USER,"registryId": $registryId,"secretValue": $DOCKER_PASSWORD}')
curl -u $RANCHER_ACCESS_KEY:$RANCHER_SECRET_KEY -silent -X POST -H 'Content-Type: application/json' -d "$REQUEST_BODY" $RANCHER_URL/projects/$RANCHER_PROJECT_ID/registryCredentials

echo "creating cloud-node-1 virtual machine"
rancher hosts create --driver softlayer --softlayer-user=${SOFTLAYER_USER} --softlayer-api-key=${SOFTLAYER_API_KEY} --softlayer-domain=slundercloud.com --softlayer-region=dal10 --softlayer-memory 12 --softlayer-cpu 8 ssiddiq-cloud-node-1

echo "creating cloud-node-2 virtual machine"
rancher hosts create --driver softlayer --softlayer-user=${SOFTLAYER_USER} --softlayer-api-key=${SOFTLAYER_API_KEY} --softlayer-domain=slundercloud.com --softlayer-region=dal10 --softlayer-memory 12 --softlayer-cpu 8 ssiddiq-cloud-node-2

echo "cleaning up environment"
unset RANCHER_API_KEYS_JSON
unset REGISTRY_ID
unset REQUEST_BODY
unset RANCHER_API_ENDPOINT
unset CREATE_REGISTRATION_TOKEN_URL
unset REGISTRATION_TOKEN

echo "successfully provisioned and configured environment"
