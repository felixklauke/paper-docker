#!/usr/bin/env bash

# Login to docker hub
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

docker build --build-arg PAPERSPIGOT_CI_JOB=$PAPERSPIGOT_CI_JOB --build-arg PAPERSPIGOT_CI_BUILDNUMBER=$PAPERSPIGOT_CI_BUILDNUMBER -t felixklauke/paperspigot:$MINECRAFT_VERSION_TAG .
docker push felixklauke/paperspigott:$MINECRAFT_VERSION_TAG
