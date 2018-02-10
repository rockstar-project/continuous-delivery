#!/bin/sh

cd $APP_HOME

cd datastore-metadata && git add . && git commit -m "updated" && git push origin master && cd -
cd datastore-product && git add . && git commit -m "updated" && git push origin master && cd -
cd datastore-collection && git add . && git commit -m "updated" && git push origin master && cd -
cd coreapi-artifact && git add . && git commit -m "updated" && git push origin master && cd -
cd coreapi-metadata && git add . && git commit -m "updated" && git push origin master && cd -
cd coreapi-product && git add . && git commit -m "updated" && git push origin master && cd -
cd coreapi-collection && git add . && git commit -m "updated" && git push origin master && cd -
