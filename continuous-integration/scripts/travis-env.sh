# export APP_HOME=$HOME/kickster-project
# export DOCKER_NAMESPACE=kicksterproject
# export DOCKER_USER=salsiddiqui0
# export DOCKER_PASSWORD=ayeteh123

travis endpoint --set-default -X -e "https://travis.ibm.com/api"
travis login -X -e "https://travis.ibm.com/api" -g $GITHUB_TOKEN

travis enable
travis env set DOCKER_REGISTRY $DOCKER_REGISTRY -P
travis env set DOCKER_NAMESPACE $DOCKER_NAMESPACE -P
travis env set DOCKER_USER $DOCKER_USER -p
travis env set DOCKER_PASSWORD $DOCKER_PASSWORD -p

travis env unset RANCHER_ENVIRONMENT
travis env unset RANCHER_ACCESS_KEY
travis env unset RANCHER_SECRET_KEY
travis env unset RANCHER_PROJECT
travis env unset RANCHER_URL
travis env set DOCKER_NAMESPACE $DOCKER_NAMESPACE -P
