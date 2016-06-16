#!/usr/bin/env bash


set -e

GO_WORKSPACE=${GO_WORKSPACE:-${HOME}/.go_workspace}
DOCKER_ORG=${DOCKER_ORG:-orangeopensource}
DOCKER_IMAGE=${DOCKER_IMAGE:-cron-resource}

REPO_NAME=github.com/pivotal-cf-experimental/cron-resource
REPO_DIR=${GO_WORKSPACE}/src/${REPO_NAME}
DOCKER_NAME=${DOCKER_NAME:-$DOCKER_ORG/$DOCKER_IMAGE}

CGO_ENABLED=0

pushd ${REPO_DIR}

  godep go test ./...
  godep go build -o built-in in/main.go
  godep go build -o built-check check/check.go

  docker build -t ${DOCKER_NAME} .
  docker run -i ${DOCKER_NAME} /bin/sh -c "sleep 5"

popd