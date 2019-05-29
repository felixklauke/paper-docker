#!/usr/bin/env bash

# Login to docker hub
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

docker build --build-arg BUKKIT_VERSION=$MINECRAFT_VERSION_TAG -t felixklauke/paperspigot:$MINECRAFT_VERSION_TAG .
docker push felixklauke/paperspigott:$MINECRAFT_VERSION_TAG
