#!/bin/sh
set -x

LC=$(git rev-parse --short HEAD)
docker build -f Dockerfile -t rotati/ror-demo:${LC} .
docker push rotati/ror-demo:${LC}