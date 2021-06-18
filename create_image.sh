#!/bin/sh

cp -r ../jianmu-ui/dist .

docker login -u $JIANMU_DOCKER_USERNAME -p $JIANMU_DOCKER_PASSWORD

docker build -f Dockerfile -t ${JIANMU_DOCKER_USERNAME}/${JIANMU_IMAGE_NAME}:${JIANMU_IMAGE_TAG} .

if [ "$JIANMU_IMAGE_TAG" != "latest" ];then
echo "push tag ${JIANMU_IMAGE_TAG}"
docker push ${JIANMU_DOCKER_USERNAME}/${JIANMU_IMAGE_NAME}:${JIANMU_IMAGE_TAG}
docker tag ${JIANMU_DOCKER_USERNAME}/${JIANMU_IMAGE_NAME}:${JIANMU_IMAGE_TAG} ${JIANMU_DOCKER_USERNAME}/${JIANMU_IMAGE_NAME}:latest
fi

echo "push tag latest"

docker push ${JIANMU_DOCKER_USERNAME}/${JIANMU_IMAGE_NAME}:latest