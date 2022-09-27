ARG DOCKER_BASE_IMAGE=wordpress:5.9.3-php7.4-apache
FROM $DOCKER_BASE_IMAGE
ARG USER=www-data
ARG UID=1000
ARG GID=1000
# default password for user

# Option1: Using unencrypted password/ specifying password
RUN groupmod -g ${GID} www-data \
    && usermod -u ${UID} www-data

USER ${UID}:${GID}