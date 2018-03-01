# install nvidia-docker 2.x
#    source: https://github.com/NVIDIA/nvidia-docker/wiki/Installation-(version-2.0)

# note to self:: remove all old first
#   docker volume ls -q -f driver=nvidia-docker | xargs -r -I{} -n1 docker ps -q -a -f volume={} | xargs -r docker rm -f
#   sudo apt-get purge nvidia-docker

curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
curl -s -L https://nvidia.github.io/nvidia-docker/ubuntu16.04/amd64/nvidia-docker.list | \
  sudo tee /etc/apt/sources.list.d/nvidia-docker.list
sudo apt-get update
sudo apt-get install -y nvidia-docker2

# add "default-runtime": "nvidia" to /etc/docker/daemon.json
sudo apt-get install -y jq
sudo jq '."default-runtime" |= "nvidia"' /etc/docker/daemon.json |sudo tee /etc/docker/daemon.json
sudo pkill -SIGHUP dockerd

# test: docker run --rm gcr.io/tensorflow/tensorflow:latest-gpu-py3 nvidia-smi
