#!/bin/bash

echo $GITHUB_REF
export BRANCH_NAME=${GITHUB_REF#refs/heads/}
echo $BRANCH_NAME

curl "https://raw.githubusercontent.com/schul-cloud/integration-tests/develop/scripts/ci/fetch.github.sh" | bash

time=$(date)
echo ::set-output name=time::$time
