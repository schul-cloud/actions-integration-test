# Container image that runs your code
FROM spotify/alpine:latest

# Copies your code file from your action repository to the filesystem path `/` of the container
COPY entrypoint.sh /entrypoint.sh
COPY switch_branch.sh /switch_branch.sh

# Make files executable
RUN ["chmod", "550", "/entrypoint.sh"]
RUN ["chmod", "550", "/switch_branch.sh"]

# Code file to execute when the docker container starts up (`entrypoint.sh`)
ENTRYPOINT ["/entrypoint.sh"]