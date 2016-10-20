#!/usr/bin/env bash

cd $( dirname $0 )

docker run \
  --name lev-api-mock \
  --rm \
  -p 8080:8080 \
  -i lev-api-mock
