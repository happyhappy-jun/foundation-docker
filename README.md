# foundation-docker

# Basic build
docker build -t ml-dev:latest .

# Build with specific version tag
docker build -t ml-dev:1.0 .
docker tag ml-dev:1.0 ml-dev:latest

# Build with different Python version
docker build --build-arg PYTHON_VERSION=3.11 -t ml-dev:latest .

# Build with different base environment name
docker build --build-arg BASE_ENV_NAME=ml -t ml-dev:latest .

# Build with both custom arguments
docker build \
    --build-arg PYTHON_VERSION=3.11 \
    --build-arg BASE_ENV_NAME=ml \
    -t ml-dev:latest .

# If you're using NVIDIA CUDA base image, you might want to use BuildKit
DOCKER_BUILDKIT=1 docker build -t ml-dev:latest .
