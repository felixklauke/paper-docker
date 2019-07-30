#!/bin/bash

# Show java version
java -version

# Show start arguments
echo "Starting with Java Args: $JAVA_ARGS"
echo "Starting with Spigot Args: $SPIGOT_ARGS"
echo "Starting with Paper Args: $PAPERSPIGOT_ARGS"

# Start server
cd $SERVER_PATH
java -jar $JAVA_ARGS $SERVER_PATH/paper.jar $SPIGOT_ARGS $PAPERSPIGOT_ARGS
