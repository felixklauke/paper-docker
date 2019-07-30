#!/usr/bin/env bash

# Login to docker hub
echo "$DOCKER_PASSWORD" | docker login -u "$DOCKER_USERNAME" --password-stdin

docker build -t felixklauke/paperspigot:$PAPER_VERSION --build-arg PAPER_VERSION=$PAPER_VERSION .
docker push felixklauke/paperspigot:$PAPER_VERSION
