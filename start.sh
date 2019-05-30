#!/usr/bin/env bash

# Create symlink for plugin volume as hotfix for some plugins who hard code their directories
ln -s $PLUGINS_PATH $MINECRAFT_PATH/server/plugins

java -version

echo "Starting with Java Args: $JAVA_ARGS"
echo "Starting with Spigot Args: $SPIGOT_ARGS"
echo "Starting with Paper Args: $PAPERSPIGOT_ARGS"

java -jar $JAVA_ARGS /opt/minecraft/server/paperspigot.jar $SPIGOT_ARGS $PAPERSPIGOT_ARGS
