#!/usr/bin/env bash

SCRIPT_HOME=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

#NB: Could generalise the below to pass in the SECRET_CONTEXT env var (where client certs are pulled from in kubernetes)
# and the TEST_URL which is the location the API being tested against. Leaving as dev for now as this is the most common use case
docker build -f ${SCRIPT_HOME}/Dockerfile -t lev-api-mock ${SCRIPT_HOME}
