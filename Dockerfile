# Base Ubuntu 
ARG UBUNTU_VERSION=18.04
# Nvidia CUDA and Deep Neuronal Networks libraries
# FROM ubuntu:18.04
# FROM nvidia/cuda:10.0-devel-ubuntu${UBUNTU_VERSION} as base
FROM nvidia/cuda:9.0-devel-ubuntu16.04
# FROM tensorflow/tensorflow:1.13.1-gpu-py3 as base
# For Building on Python and related
ENV LANG C.UTF-8

# # Cudnn library
# #ENV CUDNN_VERSION 7.6.0.64
# #ENV CUDNN_VERSION 7.5.1.10 * 
# #ENV CUDNN_VERSION 7.5.0.56 *
# #ENV CUDNN_VERSION 7.4.2.24 * 
# ENV CUDNN_VERSION 7.4.1.5
# # It worked for cuda 9 and tf 1.12
ENV CUDNN_VERSION 7.3.1.20 
# #ENV CUDNN_VERSION 7.3.0.29


RUN apt-get update && apt-get install -y --no-install-recommends \
            libcudnn7=$CUDNN_VERSION-1+cuda9.0 \
            libcudnn7-dev=$CUDNN_VERSION-1+cuda9.0 && \
    apt-mark hold libcudnn7 && \
    rm -rf /var/lib/apt/lists/*


# Development dependencies
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    python3-pip git g++ wget make python3-tk sudo ffmpeg python3-setuptools python3-dev curl
    #python3.7-dev python3.7 libpython3.7-dev

#Upgrade pip
RUN pip3 install --upgrade pip

# X Server and related
RUN apt-get update && apt-get install -y x11-xserver-utils wget gedit sudo git gcc g++ python3-dev

ARG USER_ID=1000
ARG GROUP_ID=1000

# Creates sim user and add to sudoers file
RUN groupadd -g ${GROUP_ID} sim && \
    useradd -m -l -u ${USER_ID} -g sim sim && \
    echo "sim:sim" | chpasswd && adduser sim sudo && \
    echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

ENV HOME /home/sim
ENV SIM_ROOT=$HOME

# Added to video group
RUN usermod -a -G video sim
USER sim

WORKDIR $HOME

# FaceSwap repo
RUN git clone https://github.com/deepfakes/faceswap.git

WORKDIR $HOME/faceswap

RUN sudo pip3 install -r requirements.txt

# Tensorflow
RUN sudo pip3 install tensorflow-gpu==1.12.0