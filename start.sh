#!/usr/bin/env bash
java -version

echo "Starting with Java Args: $JAVA_ARGS"
echo "Starting with Spigot Args: $SPIGOT_ARGS"
echo "Starting with Paper Args: $PAPERSPIGOT_ARGS"

java -jar $JAVA_ARGS /opt/minecraft/server/paperspigot.jar $SPIGOT_ARGS $PAPERSPIGOT_ARGS
