#!/usr/bin/env bash

# Login to docker hub
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

docker build --build-arg PAPERSPIGOT_CI_JOB=$PAPERSPIGOT_CI_JOB --build-arg PAPERSPIGOT_CI_BUILDNUMBER=$PAPERSPIGOT_CI_BUILDNUMBER --build-arg ARTIFACT_NAME=$ARTIFACT_NAME --build-arg JAVA_VERSION=$JAVA_VERSION -t felixklauke/paperspigot:$MINECRAFT_VERSION_TAG .
docker push felixklauke/paperspigot:$MINECRAFT_VERSION_TAG
