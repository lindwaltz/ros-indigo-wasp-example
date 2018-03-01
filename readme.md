# ros-indigo-wasp-example

Example repository showing how to use my dockerhub images `ros-indigo-waspbase-nvidia` and `ros-indigo-desktop-full-nvidia` to run a ROS environment with opengl enabled.

On the HOST machine you'll need:

```
sudo apt-get install ruby
./install-docker.sh
./install-nvidiadocker.sh
```

If nvidia-docker2 installed correctly, you should now be able to run:

```
docker run --rm gcr.io/tensorflow/tensorflow:latest-gpu-py3 nvidia-smi
```

If that works you are in a good position to try this repository.

```
cd rosenv/

# setup docker env and start roscore
ruby ./docker-xompose.rb up

# (in another terminal) start new console into docker environment
./new_console.sh
```
