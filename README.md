# paperspigot-docker
Easy to use and clean docker image for running paper spigot servers in docker containers using Oracle Java on Alpine Linux. 


# Getting started
The easiest way for a quick start would be:
```
docker run -it -v ~/server:/data felixklauke/paperspigot:1.12.2
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
- JAVA_ARGS (default: "-Xmx2G")
- SPIGOT_ARGS (default: "")
- PAPERSPIGOT_ARGS (default: "")

# Volumes
The containers main volume is located at `/data`. Therefor you can mount your server folder easily by
```
-v ~/server:/data
```

# docker-compose.yml
You can add this simple entry to your docker-compose.yml:
```
version: '3'  
services: 
  minecraft:
    image: felixklauke/paperspigot
    restart: always
    ports:
      - 25565:25565
    volumes:
      - /srv/minecraft:/data
```
