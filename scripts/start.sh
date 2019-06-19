#!/usr/bin/env bash
# Do preparations
# Create symlink for plugin volume as hotfix for some plugins who hard code their directories
whoami
ln -s $PLUGINS_PATH $SERVER_PATH/plugins

# Create symlink for persistent data
ln -s $DATA_PATH/banned-ips.json $SERVER_PATH/banned-ips.json
ln -s $DATA_PATH/banned-players.json $SERVER_PATH/banned-players.json
ln -s $DATA_PATH/help.yml $SERVER_PATH/help.yml
ln -s $DATA_PATH/ops.json $SERVER_PATH/ops.json
ln -s $DATA_PATH/permissions.yml $SERVER_PATH/permissions.yml
ln -s $DATA_PATH/whitelist.json $SERVER_PATH/whitelist.json

# Create symlink for logs
ln -s $LOGS_PATH $SERVER_PATH/logs

ls -la

# Show java version
java -version

# Show start arguments
echo "Starting with Java Args: $JAVA_ARGS"
echo "Starting with Spigot Args: $SPIGOT_ARGS"
echo "Starting with Paper Args: $PAPERSPIGOT_ARGS"

# Start server
java -jar $JAVA_ARGS $SERVER_PATH/paperspigot.jar $SPIGOT_ARGS $PAPERSPIGOT_ARGS
