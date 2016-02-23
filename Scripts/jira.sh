#!/bin/bash
apt-get update
wget -qO- https://get.docker.com/ | sh
#Run Docker

docker --version

