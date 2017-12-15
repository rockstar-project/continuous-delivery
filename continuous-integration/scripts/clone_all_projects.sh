#!/bin/sh

git config --global user.name "email@example.com"
git config --global user.email "email@example.com"

cd $APP_HOME
git clone https://github.ibm.com/kickster/api-gateway.git;
git clone https://github.ibm.com/kickster/discovery-service.git
git clone https://github.ibm.com/kickster/coreapi-member.git
git clone https://github.ibm.com/kickster/coreapi-template.git
git clone https://github.ibm.com/kickster/coreapi-artifact.git
git clone https://github.ibm.com/kickster/datastore-member.git
git clone https://github.ibm.com/kickster/datastore-template.git
git clone https://github.ibm.com/kickster/rockstar_intro.git
git clone https://github.ibm.com/kickster/kickster-cli.git
