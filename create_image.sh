#!/bin/sh

cp -r ../jianmu-ui/dist .

docker login -u $JIANMU_DOCKER_USERNAME -p $JIANMU_DOCKER_PASSWORD

docker build -f Dockerfile -t ${JIANMU_DOCKER_USERNAME}/${JIANMU_IMAGE_NAME}:${JIANMU_IMAGE_TAG} .

docker push $JIANMU_DOCKER_USERNAME/$JIANMU_IMAGE_NAME:$JIANMU_IMAGE_TAG
