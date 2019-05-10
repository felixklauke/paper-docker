################################
### We use a java base image ###
################################
FROM openjdk:8 AS build

#####################################
### Maintained by Felix Klauke    ###
### Contact: info@felix-klauke.de ###
#####################################
MAINTAINER Felix Klauke <info@felix-klauke.de>

#################
### Arguments ###
#################
ARG PAPERSPIGOT_CI_JOB=Paper-1.14
ARG PAPERSPIGOT_CI_BUILDNUMBER=lastSuccessfulBuild
ARG PAPERSPIGOT_CI_URL=https://papermc.io/ci/job/${PAPERSPIGOT_CI_JOB}/${PAPERSPIGOT_CI_BUILDNUMBER}/artifact/paperclip.jar

##########################
### Download paperclip ###
##########################
ADD ${PAPERSPIGOT_CI_URL} /opt/minecraft/server/paperclip.jar

############################################
### Run paperclip and obtain patched jar ###
############################################
RUN cd /opt/minecraft/server/ \
	&& java -jar paperclip.jar; exit 0

RUN cd /opt/minecraft/server/ \
	&& mv cache/patched*.jar paperspigot.jar

###########################
### Running environment ###
###########################
FROM anapsix/alpine-java:latest

##########################
### Environment & ARGS ###
##########################
ARG MINECRAFT_PATH=/opt/minecraft
ARG CONFIG_PATH=${MINECRAFT_PATH}/config
ARG WORLDS_PATH=${MINECRAFT_PATH}/worlds
ARG PLUGINS_PATH=${MINECRAFT_PATH}/plugins

ENV JAVA_ARGS "-Xmx2G -XX:+UseParNewGC -XX:+UseConcMarkSweepGC -server -Dcom.mojang.eula.agree=true"
ENV SPIGOT_ARGS "--bukkit-settings ${CONFIG_PATH}/bukkit.yml --plugins ${PLUGINS_PATH} --world-dir ${WORLDS_PATH} --spigot-settings ${CONFIG_PATH}/spigot.yml --commands-settings ${CONFIG_PATH}/commands.yml --config ${CONFIG_PATH}/server.properties"
ENV PAPERSPIGOT_ARGS "--paper-settings ${CONFIG_PATH}/paper.yml"

############
### User ###
############
RUN adduser -Ds /bin/bash -h /opt/minecraft papermc
RUN mkdir -p /opt/minecraft/server
RUN chown -R papermc /opt/minecraft
USER papermc

#########################
### Working directory ###
#########################
WORKDIR /opt/minecraft/server

###########################################
### Obtain runable jar from build stage ###
###########################################
COPY --from=build /opt/minecraft/server/paperspigot.jar .

########################
### Obtain starth.sh ###
########################
ADD start.sh .

###############
### Volumes ###
###############
VOLUME "/opt/minecraft/config"
VOLUME "/opt/minecraft/worlds"
VOLUME "/opt/minecraft/plugins"

#############################
### Expose minecraft port ###
#############################
EXPOSE 25565

######################################
### Entrypoint is the start script ###
######################################
ENTRYPOINT sh start.sh
