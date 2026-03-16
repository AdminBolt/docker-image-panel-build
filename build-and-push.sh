#!/bin/bash
set -e
IMAGE="bobibolt/bolt-panel-build"
TAG="${1:-latest}"

# Build for linux/amd64 so Jenkins (and other amd64 hosts) can pull it
docker buildx build --platform linux/amd64 -t "$IMAGE:$TAG" --push .
echo "Pushed $IMAGE:$TAG (linux/amd64)"
