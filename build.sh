#!/usr/bin/env bash
set -ex

short_sha=$(git rev-parse --short HEAD)

image_name=felds/runpod-comfy
dockerfile=Dockerfile-cuda12
tag="${short_sha}-no-models-cuda12"

docker build . --file "${dockerfile}" --platform linux/amd64 --tag "${image_name}:${tag}" --build-arg SKIP_DEFAULT_MODELS=1
docker push "${image_name}:${tag}"
