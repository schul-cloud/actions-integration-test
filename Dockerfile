# Container image that runs your code
FROM alpine:latest

# install bash and curl
RUN apk add --update \
        bash \
        curl \
    && rm -rf /var/cache/apk/*

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh

# Make entrypoint executable
RUN ["chmod", "550", "/entrypoint.sh"]

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]