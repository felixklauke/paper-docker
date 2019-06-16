# Java Version
ARG JAVA_VERSION=11

################################
### We use a java base image ###
################################
FROM openjdk:${JAVA_VERSION} AS build

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
ARG ARTIFACT_NAME=paperclip.jar
ARG PAPERSPIGOT_CI_URL=https://papermc.io/ci/job/${PAPERSPIGOT_CI_JOB}/${PAPERSPIGOT_CI_BUILDNUMBER}/artifact/${ARTIFACT_NAME}

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
FROM openjdk:${JAVA_VERSION} AS runtime

##########################
### Environment & ARGS ###
##########################
ENV MINECRAFT_PATH=/usr/src/app
ENV DATA_PATH=${MINECRAFT_PATH}/data
ENV LOGS_PATH=${MINECRAFT_PATH}/logs
ENV CONFIG_PATH=${MINECRAFT_PATH}/config
ENV WORLDS_PATH=${MINECRAFT_PATH}/worlds
ENV PLUGINS_PATH=${MINECRAFT_PATH}/plugins
ENV PROPERTIES_LOCATION=${CONFIG_PATH}/server.properties
ENV JAVA_HEAP_SIZE=2G
ENV JAVA_ARGS="-Xmx${JAVA_HEAP_SIZE} -Xms${JAVA_HEAP_SIZE} -XX:+UseConcMarkSweepGC -server -Dcom.mojang.eula.agree=true"
ENV SPIGOT_ARGS="--nojline --bukkit-settings ${CONFIG_PATH}/bukkit.yml --plugins ${PLUGINS_PATH} --world-dir ${WORLDS_PATH} --spigot-settings ${CONFIG_PATH}/spigot.yml --commands-settings ${CONFIG_PATH}/commands.yml --config ${PROPERTIES_LOCATION}"
ENV PAPERSPIGOT_ARGS="--paper-settings ${CONFIG_PATH}/paper.yml"

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
WORKDIR ${MINECRAFT_PATH}

###########################################
### Obtain runable jar from build stage ###
###########################################
COPY --from=build /opt/minecraft/server/paperspigot.jar .

########################
### Obtain starth.sh ###
########################
ADD start.sh .

############
### User ###
############
RUN useradd -ms /bin/bash minecraft && \
    chown minecraft ${MINECRAFT_PATH} -R

USER minecraft

###############
### Volumes ###
###############
VOLUME "${CONFIG_PATH}"
VOLUME "${WORLDS_PATH}"
VOLUME "${PLUGINS_PATH}"
VOLUME "${DATA_PATH}"
VOLUME "${LOGS_PATH}"

#############################
### Expose minecraft port ###
#############################
EXPOSE 25565

######################################
### Entrypoint is the start script ###
######################################
ENTRYPOINT bash start.sh
