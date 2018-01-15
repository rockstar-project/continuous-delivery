
travis endpoint --set-default -e "$TRAVIS_API_ENDPOINT"
travis login -e "$TRAVIS_API_ENDPOINT" -g $GITHUB_TOKEN

travis enable
travis env set DOCKER_NAMESPACE $DOCKER_NAMESPACE -P
travis env set DOCKER_USER $DOCKER_USER -p
travis env set DOCKER_PASSWORD $DOCKER_PASSWORD -p


travis env set AWS_ACCESS_KEY_ID $AWS_ACCESS_KEY_ID -p
travis env set AWS_SECRET_ACCESS_KEY $AWS_SECRET_ACCESS_KEY -p
