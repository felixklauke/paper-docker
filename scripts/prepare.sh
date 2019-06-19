#!/usr/bin/env bash
# Create symlink for plugin volume as hotfix for some plugins who hard code their directories
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
