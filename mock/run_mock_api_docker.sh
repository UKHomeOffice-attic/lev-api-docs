#!/usr/bin/env bash

SCRIPT_HOME=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

function build_docker_image {
    #NB: Could generalise the below to pass in the SECRET_CONTEXT env var (where client certs are pulled from in kubernetes)
    # and the TEST_URL which is the location the API being tested against. Leaving as dev for now as this is the most common use case
    sudo docker build -f $SCRIPT_HOME/Dockerfile -t lev-api-mock $SCRIPT_HOME;
}

function run_mock_api {
    sudo docker run \
      --name lev-api-mock \
      --rm \
      -p 8080:8080 \
      -i lev-api-mock
}

build_docker_image
run_mock_api
