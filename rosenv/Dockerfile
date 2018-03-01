FROM lindwaltz/ros-indigo-waspbase-nvidia

# Arguments
ARG user
ARG uid
ARG home
ARG workspace

ARG DEBIAN_FRONTEND=noninteractive

# ==== user conf

# Clone user into docker image
RUN \
  echo "${user}:x:${uid}:${uid}:${user},,,:${home}:/bin/bash" >> /etc/passwd && \
  echo "${user}:x:${uid}:" >> /etc/group && \
  echo "${user} ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/${user}" && \
  chmod 0440 "/etc/sudoers.d/${user}" && \
  usermod -a -G video "${user}" && usermod -a -G dialout "${user}" 

# Create user and mountpoint for shared folders
RUN mkdir -p "/home/${user}/.ros" && \    
    chown -R "${user}" "/home/${user}" && \
    mkdir -p "/catkin_ws/src" && chown -R "${user}" "/catkin_ws" && \
    mkdir -p "/scripts" && chown -R "${user}" "/scripts"

# Switch to user
USER "${user}"

# ROS dep installation
RUN rosdep update

RUN mkdir -p "${workspace}" && touch "${workspace}/.catkin_workspace" && \
    ln -s "/catkin_ws/src" "${workspace}/src" && \
    ln -s "/scripts" "${home}/scripts" && \
    echo "source ~/.bashrc" >> ~/.bash_profile && \
    echo "source ${home}/scripts/rosenv.sh" >> ~/.bashrc

# This is required for sharing X11 Xauthority
ENV QT_X11_NO_MITSHM=1

# Mark home directory as persistent volume
# VOLUME "{$home}"
# VOLUME "/wasp-challenge"

# Switch to the workspace
WORKDIR ${home}
