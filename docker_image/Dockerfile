############################################################
# Dockerfile to build ODOO base images (FAL)
# Based on Ubuntu 16.04
############################################################
FROM ubuntu:16.04
MAINTAINER Benoit Lavorata <benoit@sbg-live.com>

#ENVIRONMENT VARIABLES
ARG IMAGE_NAME="CUSTOM_IMAGE_NAME"
ARG IMAGE_INSTALL_SCRIPTS="CUSTOM_IMAGE_INSTALL_SCRIPTS"
ARG IMAGE_INSTALL_DIR="/container_scripts"
ARG ENTRYPOINT_DIR="/entrypoint"

#PREPARE INSTALL SCRIPT
ENV DEBIAN_FRONTEND noninteractive
COPY ./${IMAGE_INSTALL_DIR} ${IMAGE_INSTALL_DIR}
RUN chmod +x ${IMAGE_INSTALL_DIR}/*.sh
RUN .${IMAGE_INSTALL_DIR}/install.sh
#RUN rm -r ${IMAGE_INSTALL_DIR}
ENV DEBIAN_FRONTEND teletype

EXPOSE CUSTOM_EXPOSED_PORTS
ENTRYPOINT ["/entrypoint.sh"]
