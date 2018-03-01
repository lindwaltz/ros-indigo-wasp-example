#!/bin/bash
include () {
    [[ -f "$1" ]] && source "$1"
}

export WASP_WS=${WASP_WS:-$HOME/catkin_ws}
export WASP_TMP=${WASP_TMP:-$HOME/catkin_ws/tmp_data}
export WASP_IF=${WASP_IF:-wlan0}

include /usr/share/gazebo/setup.sh
include /opt/ros/indigo/setup.bash
include $WASP_WS/devel/setup.bash

#export GAZEBO_MODEL_PATH=$GAZEBO_MODEL_PATH:$WASP_WS/src/wasp1/models

if [ -z "$ROS_HOSTNAME" ]; then
  ip=$(ip -f inet -o addr show $WASP_IF|cut -d\  -f 7 | cut -d/ -f 1)
  export ROS_HOSTNAME=$ip
fi

export ROS_PACKAGE_PATH=$ROS_PACKAGE_PATH:$WASP_WS/src

# create missing directories if needed
mkdir -p $WASP_TMP/rosplan/data
mkdir -p $WASP_TMP/rosplan/knowledge_base_mongoDB

echo "WASP ROS Environment successfully configured. MASTER: '$ROS_MASTER_URI' HOST: '$ROS_HOSTNAME'"
