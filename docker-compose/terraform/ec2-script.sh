#! /bin/bash

sudo apt update -y

sudo curl -fsSL https://get.docker.com | sh

sudo usermod -aG docker ubuntu

sudo systemctl enable docker
sudo systemctl start docker

sudo curl -SL https://github.com/docker/compose/releases/download/v2.34.0/docker-compose-linux-x86_64 -o /usr/local/bin/docker-compose

sudo chmod +x /usr/local/bin/docker-compose
