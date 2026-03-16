#!/bin/bash
set -e
IMAGE="bobibolt/bolt-panel-build"
TAG="${1:-latest}"

# Build for linux/amd64 so Jenkins (and other amd64 hosts) can pull it
docker buildx build --platform linux/amd64 -t "$IMAGE:$TAG" -t "$IMAGE:v4.1" --push .
echo "Pushed $IMAGE:$TAG and $IMAGE:v4.1 (linux/amd64)"
