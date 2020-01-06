#!/bin/bash

echo $GITHUB_REF
export BRANCH_NAME=${GITHUB_REF##*/}

switchBranch(){
  if [[ $BRANCH_NAME = release* || $BRANCH_NAME = hotfix* ]]
  then
    bash switch_branch.sh "$1" "master"
  fi
  bash switch_branch.sh "$1" "$BRANCH_NAME"
}

fetch(){
  # make switch branch script executable
  chmod 700 switch_branch.sh

  # clone all required repositories and try to switch to branch with same name as current one
  git clone https://github.com/schul-cloud/nuxt-client.git nuxt-client
  switchBranch "nuxt-client"

  git clone https://github.com/schul-cloud/schulcloud-client.git schulcloud-client
  switchBranch "schulcloud-client"

  git clone https://github.com/schul-cloud/schulcloud-server.git schulcloud-server
  switchBranch "schulcloud-server"

  git clone https://github.com/schul-cloud/docker-compose.git docker-compose
  switchBranch "docker-compose"

  git clone https://github.com/schul-cloud/integration-tests.git integration-tests
  switchBranch "integration-tests"
}

install(){
  npm install -g wait-on

  cd docker-compose
  docker-compose -f docker-compose.integration-test.yml build --parallel
  docker-compose -f docker-compose.integration-test.yml up -d
  cd ..

  cd integration-tests && npm ci && cd ..
}

before(){
  cd schulcloud-server && npm run setup && npm run seed && cd ..

  # wait for the nuxt client to be available
  echo "waiting max 60s for nuxt to be available"
  wait-on http://localhost:4000 -t 60000
  echo "nuxt is now online"
}

main(){
  cd integration-tests
  npm run test
  cd ..
}

set -e
fetch
install
before
main
set +e

time=$(date)
echo ::set-output name=time::$time