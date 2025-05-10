# Use an arm64 base image
FROM ubuntu:24.04

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    cmake-extras \
    wget \
    qt6-base-dev \
    qt6-tools-dev \
    qt6-tools-dev-tools \
    qt6-multimedia-dev \
    libqt6svg6-dev \
    libqt6svg6 \
    libqt6network6 \
    libqt6core5compat6 \
    libqt6gui6 \
    libqt6widgets6 \
    libqt6opengl6 \
    libqt6opengl6-dev \
    libqt6multimedia6 \
    libqt6multimediawidgets6 \
    libfmt-dev \
    libjpeg-turbo8-dev \
    libpng-dev \
    zlib1g-dev \
    libfreetype-dev \
    libfontconfig-dev \
    libsndfile1-dev \
    libmpg123-dev \
    libopenmpt-dev \
    libfluidsynth-dev \
    file \
    git \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
RUN git clone https://github.com/garglk/garglk.git
RUN cd garglk && git submodule update --init --recursive
WORKDIR /garglk

# Copy the build script
COPY gargoyle-appimage.sh /garglk/build.sh

# Make the build script executable
RUN chmod +x /garglk/build.sh
# Build the application
#/garglk/build.sh

RUN "/garglk/build.sh"
