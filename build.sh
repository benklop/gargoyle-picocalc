#!/bin/bash -ex

# This script builds the Gargoyle AppImage for aarch64 architecture.

docker build --platform=linux/arm64 -t gargoyle-appimage .
docker rm -f gargoyle-amd64
docker run --name gargoyle-arm64 --platform=linux/arm64 -it gargoyle-appimage
docker cp gargoyle-arm64:/garglk/Gargoyle-aarch64.AppImage .
docker rm -f gargoyle-arm64
docker rmi gargoyle-appimage