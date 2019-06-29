############################################################
# Dockerfile to build ODOO base images (FAL)
# Based on CUSTOM_IMAGE_SOURCE
############################################################
FROM CUSTOM_IMAGE_SOURCE
MAINTAINER CUSTOM_IMAGE_MAINTAINER

#ENVIRONMENT VARIABLES
ARG IMAGE_NAME="CUSTOM_IMAGE_NAME"
ARG IMAGE_INSTALL_SCRIPTS="CUSTOM_IMAGE_INSTALL_SCRIPTS"

#PREPARE INSTALL SCRIPT
ENV DEBIAN_FRONTEND noninteractive
RUN wget https://raw.githubusercontent.com/sbglive/compose/master/install.sh
RUN chmod +x install.sh
RUN ./install.sh
RUN rm install.sh
RUN app $IMAGE_INSTALL_SCRIPTS
#COPY ./${IMAGE_INSTALL_DIR} ${IMAGE_INSTALL_DIR}
#RUN chmod +x ${IMAGE_INSTALL_DIR}/*.sh
#RUN .${IMAGE_INSTALL_DIR}/install.sh
#RUN rm -r ${IMAGE_INSTALL_DIR}
ENV DEBIAN_FRONTEND teletype

EXPOSE CUSTOM_IMAGE_EXPOSED_PORTS
ENTRYPOINT ["/boot.sh"]
