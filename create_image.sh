#!/bin/sh
set -e

${JIANMU_CMD_PRE}

docker login -u ${JIANMU_DOCKER_USERNAME} -p ${JIANMU_DOCKER_PASSWORD}

set -x

docker build -f Dockerfile -t ${JIANMU_IMAGE_NAME}:${JIANMU_IMAGE_TAG} ${JIANMU_DOCKER_BUILD_PATH}

if [ "$JIANMU_IMAGE_TAG" != "latest" ];then

docker push ${JIANMU_IMAGE_NAME}:${JIANMU_IMAGE_TAG}
docker tag ${JIANMU_DOCKER_USERNAME}/${JIANMU_IMAGE_NAME}:${JIANMU_IMAGE_TAG} ${JIANMU_DOCKER_USERNAME}/${JIANMU_IMAGE_NAME}:latest
fi


docker push ${JIANMU_IMAGE_NAME}:latest