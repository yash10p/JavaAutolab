#!/bin/bash

sudo true

#install docker dependecy for AUFS file system
sudo apt-get install lxc wget bsdtar curl
sudo apt-get install linux-image-extra-$(uname -r)
sudo modprobe aufs
wget -qO- https://get.docker.com/ | sh

sudo apt update
sudo apt install -y python-pip libssl-dev sshpass libffi-dev build-essential python-dev
sudo pip install --upgrade pip
sudo pip install cryptography
sudo pip install ansible
sudo service docker restart
cat << EOF
Done installing base packages
You may now edit the configuration files in configs directory and execute
'ansible-playbook -i inventory playbook.yml -u <username> --ask-sudo-pass'
to install JavaAutoLab
EOF
