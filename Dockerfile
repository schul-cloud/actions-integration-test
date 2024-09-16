# Container image that runs your code
FROM ubuntu:xenial

# install dependencies
RUN apt-get update && \
    apt-get install -y apt-transport-https ca-certificates wget curl git

# mongo tools
RUN wget -qO - https://www.mongodb.org/static/pgp/server-4.2.asc | apt-key add -
RUN echo "deb [ arch=amd64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.2 multiverse" | tee /etc/apt/sources.list.d/mongodb-org-4.2.list
RUN apt-get update && \
    apt-get install -y mongodb-org-tools

# docker (compose)
RUN curl -fsSL https://get.docker.com -o get-docker.sh
RUN sh get-docker.sh
RUN curl -L "https://github.com/docker/compose/releases/download/1.24.0/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
RUN chmod +x /usr/local/bin/docker-compose

RUN curl -sL https://deb.nodesource.com/setup_10.x | bash
RUN apt-get update && apt-get install -y nodejs

# node
RUN node --version
RUN npm --version
ENV npm_config_user=root

ENV IT_CLIENT_HOST=nuxtclient
ENV IT_CLIENT_PORT=4000
ENV SERVER_BACKUP_DEFAULT_URI=0.0.0.0:27017

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh ./

# Make files executable
RUN ["chmod", "550", "entrypoint.sh"]

# Code file to execute when the docker container starts up (`entrypoint.sh`)
CMD [ "bash", "entrypoint.sh" ]
