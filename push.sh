#!/bin/sh
set -x

LC=$(git rev-parse --short HEAD)
docker build -f Dockerfile -t jensendarren/ror-demo:${LC} .
# docker push jensendarren/ror-demo:${LC}