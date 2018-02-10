#!/bin/bash

SWARM_PORT=2377
STACK_NAME=$1
REGION=us-west-1
VPC=vpc-3d16dc59
SUBNET=subnet-5aaa1f02
ZONE=c
SECURITY_GROUP=${SLACK_NAME}-swarmmanager-sg
#SECURITY_GROUP_ID=sg-faa47583

docker-machine create -d amazonec2 --amazonec2-vpc-id $VPC --amazonec2-region $REGION --amazonec2-zone $ZONE --amazonec2-instance-type t2.micro --amazonec2-subnet-id $SUBNET --amazonec2-security-group $SECURITY_GROUP ${STACK_NAME}-swarm-manager
docker-machine create -d amazonec2 --amazonec2-vpc-id $VPC --amazonec2-region $REGION --amazonec2-zone $ZONE --amazonec2-instance-type t2.micro --amazonec2-subnet-id $SUBNET --amazonec2-security-group $SECURITY_GROUP ${STACK_NAME}-swarm-worker1
docker-machine create -d amazonec2 --amazonec2-vpc-id $VPC --amazonec2-region $REGION --amazonec2-zone $ZONE --amazonec2-instance-type t2.micro --amazonec2-subnet-id $SUBNET --amazonec2-security-group $SECURITY_GROUP ${STACK_NAME}-swarm-worker2
docker-machine create -d amazonec2 --amazonec2-vpc-id $VPC --amazonec2-region $REGION --amazonec2-zone $ZONE --amazonec2-instance-type t2.micro --amazonec2-subnet-id $SUBNET --amazonec2-security-group $SECURITY_GROUP ${STACK_NAME}-swarm-worker3
docker-machine create -d amazonec2 --amazonec2-vpc-id $VPC --amazonec2-region $REGION --amazonec2-zone $ZONE --amazonec2-instance-type t2.micro --amazonec2-subnet-id $SUBNET --amazonec2-security-group $SECURITY_GROUP ${STACK_NAME}-swarm-worker4

export SECURITY_GROUP_ID=$(aws ec2 create-security-group --group-name ${SECURITY_GROUP} --description "${STACK_NAME} security group" --vpc-id ${VPC} | jq .SecurityGroups[0].GroupId))
#export SECURITY_GROUP_ID=$(aws ec2 describe-security-groups --filter "Name=group-name,Values=${SECURITY_GROUP}" | jq .SecurityGroups[0].GroupId))

aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 2377 --source-group $SECURITY_GROUP_ID
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 7946 --source-group $SECURITY_GROUP_ID
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol udp --port 7946 --source-group $SECURITY_GROUP_ID
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol tcp --port 4789 --source-group $SECURITY_GROUP_ID
aws ec2 authorize-security-group-ingress --group-id $SECURITY_GROUP_ID --protocol udp --port 4789 --source-group $SECURITY_GROUP_ID

SWARM_MANAGER_IP=$(docker-machine ip ${STACK_NAME}-swarm-manager)
SWARM_MANAGER_INTERNAL_IP=$(docker-machine ssh ${STACK_NAME}-swarm-manager ifconfig eth0)

eval $(docker-machine env ${STACK_NAME}-swarm-manager)
docker swarm init --advertise-addr=${SWARM_MANAGER_INTERNAL_IP}
export TOKEN=$(docker swarm join-token -q worker)

eval $(docker-machine env ${SLACK_NAME}-swarm-worker1)
docker swarm join --token $TOKEN ${SWARM_MANAGER_INTERNAL_IP}:${SWARM_PORT}

eval $(docker-machine env ${SLACK_NAME}-swarm-worker2)
docker swarm join --token $TOKEN ${SWARM_MANAGER_INTERNAL_IP}:${SWARM_PORT}

eval $(docker-machine env ${SLACK_NAME}-swarm-worker3)
docker swarm join --token $TOKEN ${SWARM_MANAGER_INTERNAL_IP}:${SWARM_PORT}

eval $(docker-machine env ${SLACK_NAME}-swarm-worker4)
docker swarm join --token $TOKEN ${SWARM_MANAGER_INTERNAL_IP}:${SWARM_PORT}

# verify the cluster

eval $(docker-machine env ${STACK_NAME}-swarm-manager)
docker node update --label-add type=gateway ${STACK_NAME}-swarm-manager

docker node ls
