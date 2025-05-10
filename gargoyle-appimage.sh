#!/bin/bash

set -ex

# https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-x86_64.AppImage
# https://github.com/linuxdeploy/linuxdeploy-plugin-appimage/releases/download/continuous/linuxdeploy-plugin-appimage-x86_64.AppImage
# https://github.com/linuxdeploy/linuxdeploy-plugin-qt/releases/download/continuous/linuxdeploy-plugin-qt-x86_64.AppImage

mkdir build-appimage
cd build-appimage

arch=$(uname -m)
case "$arch" in
    x86_64)
        arch_suffix="x86_64"
        ;;
    aarch64)
        arch_suffix="aarch64"
        ;;
    *)
        echo "Unsupported architecture: $arch"
        exit 1
        ;;
esac
xargs -n 1 -P 0 wget -q <<EOF
https://github.com/linuxdeploy/linuxdeploy/releases/download/continuous/linuxdeploy-${arch_suffix}.AppImage
https://github.com/linuxdeploy/linuxdeploy-plugin-appimage/releases/download/continuous/linuxdeploy-plugin-appimage-${arch_suffix}.AppImage
https://github.com/linuxdeploy/linuxdeploy-plugin-qt/releases/download/continuous/linuxdeploy-plugin-qt-${arch_suffix}.AppImage
EOF

chmod +x linuxdeploy*
cmake .. -DCMAKE_BUILD_TYPE=Release \
         -DCMAKE_INSTALL_PREFIX=/usr \
         -DCMAKE_INSTALL_LIBDIR=lib \
         -DAPPIMAGE=TRUE \
         -DBUILD_SHARED_LIBS=OFF \
         -DQT_QMAKE_PLATFORM="linuxfb:fb=/dev/fb0" \
         -DWITH_FREEDESKTOP=OFF \
         -DWITH_KDE=OFF \
         -DWITH_TTS=DYNAMIC \
         -DSOUND=QT
make "-j$(nproc)"
make install DESTDIR=AppDir

APPIMAGE_EXTRACT_AND_RUN=TRUE \
    QT_INSTALL_PLUGINS=/usr/lib/${arch_suffix}-linux-gnu/qt6/plugins/ \
    EXTRA_QT_MODULES=multimedia \
    EXTRA_PLATFORM_PLUGINS=libqlinuxfb.so \
    OUTPUT=../Gargoyle-${arch_suffix}.AppImage \
    ./linuxdeploy-${arch_suffix}.AppImage \
    --appdir=AppDir \
    --plugin qt \
    --icon-file=../garglk/gargoyle-house.png \
    --icon-filename=io.github.garglk.Gargoyle \
    -d ../garglk/gargoyle.desktop \
    --output=appimage
