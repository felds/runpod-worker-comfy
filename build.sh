#!/usr/bin/env bash
set -ex

SHORT_SHA=$(git rev-parse --short HEAD)
IMAGE_NAME=felds/runpod-comfy

TAG="${SHORT_SHA}-no-models"
docker build . --platform linux/amd64 --tag "${IMAGE_NAME}:${TAG}" --build-arg SKIP_DEFAULT_MODELS=1
docker push "${IMAGE_NAME}:${TAG}"
