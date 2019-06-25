# Base Ubuntu 
ARG UBUNTU_VERSION=18.04
# Nvidia CUDA and Deep Neuronal Networks libraries
#FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu${UBUNTU_VERSION} as base
FROM nvidia/cuda:10.0-cudnn7-devel-ubuntu${UBUNTU_VERSION} as base
# For Building on Python and related
ENV LANG C.UTF-8

# Development dependencies
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    python3-pip git g++ wget make python3-tk sudo ffmpeg python3-setuptools

#Upgrade pip
RUN pip3 install --upgrade pip

# Numpy stack and opencv for python and faceswap requirements
#RUN pip3 install opencv-python tqdm psutil pathlib numpy==1.16.2 opencv-python scikit-image \
#    Pillow scikit-learn toposort fastcluster matplotlib==2.2.2 imageio==2.5.0 imageio-ffmpeg \
#    ffmpy==0.2.2 nvidia-ml-py3 h5py==2.9.0 Keras==2.2.4

# X Server and related
RUN apt-get update && apt-get install -y x11-xserver-utils

# patch for tensorflow:latest-gpu-py3 image
# RUN cd /usr/local/cuda/lib64 \
# && mv stubs/libcuda.so ./ \
# && ln -s libcuda.so libcuda.so.1 \
# && ldconfig

ARG USER_ID=1000
ARG GROUP_ID=1000

# Creates sim user and add to sudoers file
RUN groupadd -g ${GROUP_ID} sim && \
    useradd -m -l -u ${USER_ID} -g sim sim && \
    echo "sim:sim" | chpasswd && adduser sim sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

# Wheel tf
ENV HOME /home/sim
ENV SIM_ROOT=$HOME

# Added to video group
RUN usermod -a -G video sim
USER sim

WORKDIR $HOME

# FaceSwap repo
RUN git clone https://github.com/deepfakes/faceswap.git

WORKDIR $HOME/faceswap