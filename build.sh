#!/bin/bash -ex

# This script builds the Gargoyle AppImage for aarch64 architecture.

docker build --platform=linux/armhf -t gargoyle-appimage .
docker rm -f gargoyle-armhf
docker run --name gargoyle-armhf --platform=linux/armhf -it gargoyle-appimage
docker cp gargoyle-armhf:/garglk/Gargoyle-armhf.AppImage .
docker rm -f gargoyle-armhf
docker rmi gargoyle-appimage