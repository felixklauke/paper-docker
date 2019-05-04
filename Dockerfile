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
ARG PAPERSPIGOT_CI_BUILDNUMBER=1613
ARG PAPERSPIGOT_CI_URL=https://papermc.io/ci/job/Paper/${PAPERSPIGOT_CI_BUILDNUMBER}/artifact/paperclip-${PAPERSPIGOT_CI_BUILDNUMBER}.jar

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

###################
### Environment ###
###################
ENV JAVA_ARGS "-Xmx2G"
ENV SPIGOT_ARGS ""
ENV PAPERSPIGOT_ARGS ""

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
VOLUME "/data"

#############################
### Expose minecraft port ###
#############################
EXPOSE 25565

######################################
### Entrypoint is the start script ###
######################################
ENTRYPOINT sh start.sh
