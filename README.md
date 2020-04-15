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

Clone the repo
```
git clone git@github.com:VertexStudio/simbotic-faceswap.git
```

Execute the setup.sh 
```
./setup.sh
```


Inside the recent clone repo type:

```
docker-compose up -d --build
```

This will build and start the container.

Test the installation

```
./test_installation.sh
```
It should print, everythin related with `tensorflow-gpu`
## Running

Execute the gui from faceswap using the bash script:

```
./run_gui.sh
```

## Command Line usage

### Extract faces
Run the following script

```
./extract_photos.sh /data/path/to/photos /data/path/to/faces
```

Where `path/to/photos` should reside inside `data` directory created with `./setup.sh` script and it would contain all the photos that we need to extract the faces.

`path/to/faces` should reside inside `data` directory created with `./setup.sh` script it would contain all the extracted faces after the process finish.

Example:

```
./extract_photos.sh /data/source/yoda /data/faces/yoda
```

### Train model

Run the script
```
./train_model.sh /data/path/to/A/faces /data/path/to/B/faces /data/path/to/modelAB
```

Same as the Extract faces part, but in this case we need to specify where the model should be saved (following the `/data/` as a parent directory)

```
./train_model.sh /data/faces/liam_neeson /data/faces/yoda /data/model/liam_yoda_model/
```


## Troubleshooting

```
Tensorflow raised an unknown error. This is most likely caused by a failure to launch cuDNN which can occur for some GPU/Tensorflow combinations. You should enable `allow_growth` to attempt to resolve this issue
```
To solve this issue, you need to change `allow_growth` to `True` inside `faceswap/config/extract.ini`
