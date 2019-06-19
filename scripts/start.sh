#!/usr/bin/env bash
# Do preparations
bash prepare.sh

# Show java version
java -version

# Show start arguments
echo "Starting with Java Args: $JAVA_ARGS"
echo "Starting with Spigot Args: $SPIGOT_ARGS"
echo "Starting with Paper Args: $PAPERSPIGOT_ARGS"

# Start server
java -jar $JAVA_ARGS $SERVER_PATH/paperspigot.jar $SPIGOT_ARGS $PAPERSPIGOT_ARGS
