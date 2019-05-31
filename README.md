# paperspigot-docker
Easy to use and clean docker image for running paper spigot servers in docker containers using Oracle Java on Alpine Linux. 

# Getting started
The easiest way for a quick start would be:
```
docker run -it felixklauke/paperspigot:1.12.2
```

# Tags and Versions
The docker images are tagged for their minecraft versions. Therefor you can currently choose between this versions:
- `felixklauke/paperspigot:1.14.2` 
- `felixklauke/paperspigot:1.14.1` 
- `felixklauke/paperspigot:1.13.2` 
- `felixklauke/paperspigot:1.12.2`
- `felixklauke/paperspigot:1.11.2`
- `felixklauke/paperspigot:1.10.2`
- `felixklauke/paperspigot:1.9.4`
- `felixklauke/paperspigot:1.8.8`

# Volumes
There are three volumes used for:
- Worlds
- Plugins
- Config files (paper.yml, bukkit.yml, spigot.yml, server.properties, commands.yml)
- Data (banned-ips.json, banned-players.json, help.yml, ops.json, permissions.yml, whitelist.json)

You can find the mount locations in the `docker-compose.yml`

# docker-compose.yml
You can add this simple entry to your docker-compose.yml:
```

version: '3.7'

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
      - ./data:/opt/minecraft/data
```
