################################
### We use a java base image ###
################################
FROM openjdk:11 AS build

#####################################
### Maintained by Felix Klauke    ###
### Contact: info@felix-klauke.de ###
#####################################
LABEL maintainer="Felix Klauke <info@felix-klauke.de>"

#################
### Arguments ###
#################
ARG PAPERSPIGOT_CI_JOB=Paper
ARG PAPERSPIGOT_CI_BUILDNUMBER=1613
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
FROM openjdk:11 AS runtime

##########################
### Environment & ARGS ###
##########################
ARG MINECRAFT_PATH=/opt/minecraft
ARG CONFIG_PATH=${MINECRAFT_PATH}/config
ARG WORLDS_PATH=${MINECRAFT_PATH}/worlds
ARG PLUGINS_PATH=${MINECRAFT_PATH}/plugins

ENV PROPERTIES_LOCATION=${CONFIG_PATH}/server.properties
ENV JAVA_HEAP_SIZE=2G
ENV JAVA_ARGS "-Xmx${JAVA_HEAP_SIZE} -Xms${JAVA_HEAP_SIZE} -XX:+UseConcMarkSweepGC -server -Dcom.mojang.eula.agree=true"
ENV SPIGOT_ARGS "--nojline --bukkit-settings ${CONFIG_PATH}/bukkit.yml --plugins ${PLUGINS_PATH} --world-dir ${WORLDS_PATH} --spigot-settings ${CONFIG_PATH}/spigot.yml --commands-settings ${CONFIG_PATH}/commands.yml --config ${PROPERTIES_LOCATION}"
ENV PAPERSPIGOT_ARGS "--paper-settings ${CONFIG_PATH}/paper.yml"

#################
### Libraries ###
#################
ADD https://bootstrap.pypa.io/get-pip.py .
RUN python get-pip.py

RUN pip install mcstatus

###################
### Healthcheck ###
###################
HEALTHCHECK --interval=10s --timeout=5s \
    CMD mcstatus localhost:$( cat $PROPERTIES_LOCATION | grep "server-port" | cut -d'=' -f2 ) ping

#########################
### Working directory ###
#########################
WORKDIR /opt/minecraft/server

############
### User ###
############
RUN useradd -ms /bin/bash minecraft && \
    chown minecraft /opt/minecraft -R

USER minecraft

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
ENTRYPOINT bash start.sh
