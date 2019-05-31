#!/usr/bin/env bash

# Create symlink for plugin volume as hotfix for some plugins who hard code their directories
ln -s $PLUGINS_PATH $MINECRAFT_PATH/server/plugins

# Create symlink for persistent data
ln -s $DATA_PATH/banned-ips.json $MINECRAFT_PATH/server/banned-ips.json
ln -s $DATA_PATH/banned-players.json $MINECRAFT_PATH/server/banned-players.json
ln -s $DATA_PATH/help.yml $MINECRAFT_PATH/server/help.yml
ln -s $DATA_PATH/ops.json $MINECRAFT_PATH/server/ops.json
ln -s $DATA_PATH/permissions.yml $MINECRAFT_PATH/server/permissions.yml
ln -s $DATA_PATH/whitelist.json $MINECRAFT_PATH/server/whitelist.json

# Create symlink for logs
ln -s $LOGS_PATH $MINECRAFT_PATH/server/logs

# Show java version
java -version

# Show start arguments
echo "Starting with Java Args: $JAVA_ARGS"
echo "Starting with Spigot Args: $SPIGOT_ARGS"
echo "Starting with Paper Args: $PAPERSPIGOT_ARGS"

# Start server
java -jar $JAVA_ARGS /opt/minecraft/server/paperspigot.jar $SPIGOT_ARGS $PAPERSPIGOT_ARGS
