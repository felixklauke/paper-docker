# paperspigot-docker
Easy to use and clean docker image for running paper spigot servers in docker containers using Oracle Java on Alpine Linux. 

# Getting started
The easiest way for a quick start would be:
```
docker run -it felixklauke/paperspigot:1.12.2
```

# Tags and Versions
The docker images are tagged for their minecraft versions. Therefor you can currently choose between this versions:
- `felixklauke/paperspigot:1.13.1` (Use with Caution, development build!)
- `felixklauke/paperspigot:1.12.2`
- `felixklauke/paperspigot:1.11.2`
- `felixklauke/paperspigot:1.10.2`
- `felixklauke/paperspigot:1.9.4`
- `felixklauke/paperspigot:1.8.8`

# Run arguments
You can give three kind of environment parameters to configure how the server is actually run. These are
- JAVA_ARGS (default: "-Xmx2G -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -server -Dcom.mojang.eula.agree=true")
- SPIGOT_ARGS (default: "--bukkit-settings ${CONFIG_PATH}/bukkit.yml --plugins ${PLUGINS_PATH} --world-dir ${WORLDS_PATH} --spigot-settings ${CONFIG_PATH}/spigot.yml --commands-settings ${CONFIG_PATH}/commands.yml --config ${CONFIG_PATH}/server.properties")
- PAPERSPIGOT_ARGS (default: "--paper-settings ${CONFIG_PATH}/paper.yml")

# Volumes
There are three volumes used for:
- Worlds
- Plugins
- Config files (paper.yml, bukkit.yml, spigot.yml, server.properties, commands.yml)

You can find the mount locations in the `docker-compose.yml`

# docker-compose.yml
You can add this simple entry to your docker-compose.yml:
```

version: '3'

services:
  minecraft:
    image: felixklauke/paperspigot:1.12.2
    stdin_open: true
    tty: true
    restart: always
    ports:
      - 25565:25565
    volumes:
      - ./config:/opt/minecraft/config
      - ./worlds:/opt/minecraft/worlds
      - ./plugins:/opt/minecraft/plugins
```
