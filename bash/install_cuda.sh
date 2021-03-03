#!/bin/bash
set -e -o pipefail -o noglob
set -x

CUDA_VERSION=10.2
CUDNN_VERSION=7

UBUNTU_RELEASE=$(lsb_release -rs) # 18.04
DISTRO=ubuntu${UBUNTU_RELEASE//\./} # ubuntu1804

sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/${DISTRO}/x86_64/7fa2af80.pub
# For CUDA
sudo add-apt-repository --no-update "deb http://developer.download.nvidia.com/compute/cuda/repos/${DISTRO}/x86_64/ /"
# For cuDNN and TensorRT
sudo add-apt-repository --no-update "deb http://developer.download.nvidia.com/compute/machine-learning/repos/${DISTRO}/x86_64 /"
# Need the latest drivers, but the ones installed by cuda-drivers cause issues for 32-bit applications, such as Wine and Steam
sudo add-apt-repository --no-update -y ppa:graphics-drivers/ppa
sudo apt-get update

# Install the latest driver
# Can add --gpgpu when only headless drivers are needed, e.g. when installing on a server
sudo ubuntu-drivers install

# Installing the cuda-toolkit-x-x rather than the cuda-x-x meta-package,
# since the toolkit one does not add the unwanted cuda-drivers dependency.
sudo apt-get install -y cuda-toolkit-"${CUDA_VERSION//\./-}"
sudo apt-get install -y libcudnn${CUDNN_VERSION}-dev

# Optional command for installing TensorRT
# The machine-learning repo does not contain the tensorrt meta-package,
# so the packages will have to be installed individually.
install-tensorrt() {
  sudo apt-get install -y \
    libnvinfer-dev \
    libnvinfer-plugin-dev \
    libnvparsers-dev \
    libnvonnxparsers-dev \
    python-libnvinfer-dev \
    python3-libnvinfer-dev \
    uff-converter-tf
    # The following are not included in the machine-learning repo
    # libnvinfer-bin
    # libnvinfer-samples
    # libnvinfer-doc
}
