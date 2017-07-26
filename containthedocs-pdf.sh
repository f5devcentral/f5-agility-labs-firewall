#!/usr/bin/env bash

set -x

. ./containthedocs-image

exec docker run --rm -it \
  -v $PWD:$PWD --workdir $PWD \
  ${DOCKER_RUN_ARGS} \
  -e root \
  ${DOC_IMG} make -C docs latexpdf
