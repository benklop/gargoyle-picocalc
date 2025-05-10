# Gargoyle PicoCalc

Gargoyle PicoCalc is a project designed to build an AppImage for the Gargoyle interactive fiction interpreter, specifically targeting the `aarch64` architecture as used by the LuckFox Lyra.

## Project Structure

- **Dockerfile**: Defines the build environment and dependencies for compiling Gargoyle.
- **gargoyle-appimage.sh**: A script to build the AppImage using `linuxdeploy` and its plugins.
- **build.sh**: A script to automate the Docker-based build process for the AppImage.

## Prerequisites

Ensure the following are installed on your system:

- Docker
- Bash shell
- Internet connection (to download dependencies)

## Building the AppImage

1. Clone the repository:
```bash
git clone https://github.com/your-repo/gargoyle-picocalc.git
cd gargoyle-picocalc
```

2. Run the build script:
```bash
./build.sh
```

This script will:
   - Build a Docker image with the necessary dependencies.
   - Compile Gargoyle inside the Docker container.
   - Extract the resulting AppImage from the container.

3. After the build completes, the AppImage will be available in the project directory as `Gargoyle-aarch64.AppImage`.

## Notes

- The project currently targets the `aarch64` architecture. Modify the `build.sh` script if you need to target a different architecture.
- Ensure that Docker is configured to support the `linux/arm64` platform.

## License

This project is licensed under the terms of the [MIT License](LICENSE).

## Acknowledgments

- [Gargoyle](https://github.com/garglk/garglk): The interactive fiction interpreter.
- [linuxdeploy](https://github.com/linuxdeploy): Tools for creating AppImages.
