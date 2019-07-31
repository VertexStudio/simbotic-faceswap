# Simbotic Faceswap
Docker container for Faceswap python application. 

# Prerequisites

- Docker CE 18.x
- docker-compose 1.23.x
- Nvidia Docker

## Docker

Please refer to [Offical docker documentation](https://docs.docker.com/install/linux/docker-ce/ubuntu/) to install docker for Ubuntu 18.04

## Docker Compose

[Official docker compose installation](https://docs.docker.com/compose/install/)

## Nvidia Docker

Official [repository](https://github.com/NVIDIA/nvidia-docker)

```
# Add the package repositories

curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | \
 sudo apt-key add -
distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
 sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update


# Install nvidia-docker2 and reload the Docker daemon configuration
sudo apt-get install -y nvidia-docker2
sudo pkill -SIGHUP dockerd
```

## Allow X Server connections

For open windows/guis inside the container, in your host machine type the following:

```
xhost +
```

Now we are ready to proceed


# Build and Running

Execute the setup.sh 
```
./setup.sh
```
Clone the repo
```
git clone git@github.com:VertexStudio/simbotic-faceswap.git
```

Inside the recent clone repo type:

```
docker-compose up -d --build
```

This will build and start the container.

## Running

Execute the gui from faceswap using the bash script:

```
./run_gui.sh
```