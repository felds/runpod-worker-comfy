#!/usr/bin/env bash
set -ex

SHORT_SHA=$(git rev-parse --short HEAD)

IMAGE_NAME=felds/runpod-comfy

VERSION="${SHORT_SHA}-ipadapter"
TAG_LOCAL="${IMAGE_NAME}:${VERSION}"
TAG_REMOTE="public.ecr.aws/f0x4i4f8/gpu-serverless-public:${VERSION}"

docker build . --platform linux/amd64 --tag $TAG_LOCAL --tag $TAG_REMOTE
docker push $TAG_REMOTE

