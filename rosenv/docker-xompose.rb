#!/usr/bin/env ruby
require 'tempfile'

USER = ENV['USER']
UID = `id -u #{USER}`
HOME = ENV['HOME']
WORKSPACE = HOME + "/catkin_ws"

BUILD_NAME = 'wasp_example'

compose_yaml = %Q|
version: '3'

services:
  dev:
    build:
      context: .
      args:
        user: #{USER}
        uid: #{UID}
        home: #{HOME}
        workspace: #{WORKSPACE}
    image: 'ros:#{BUILD_NAME}-#{USER}'
    container_name: '#{BUILD_NAME}_dev_#{USER}'
    privileged: true
    network_mode: "host"
    command: bash -c 'echo "starting roscore" && roscore -v'
    #command: roscore -v
    tty: true
    environment:
      - DISPLAY=:0
      - DOCKER=1
      - TERM=xterm-256color
      - WASP_IF=eth0
    volumes:
      - ros-#{BUILD_NAME}-#{USER}-home:/home/#{USER}
      - ./catkin_src:/catkin_ws/src:rw
      - ./etc:/scripts
      - /tmp/.X11-unix:/tmp/.X11-unix:rw

volumes:
  ros-#{BUILD_NAME}-#{USER}-home: {}
|

f = Tempfile.new(['tmp-docker-compose', '.yml'], ".")
begin
  f.write(compose_yaml)
  f.close
  pid = spawn("docker-compose -f #{f.path} #{ARGV.join(' ')}")
  Process.wait pid
ensure
  f.unlink  
end
