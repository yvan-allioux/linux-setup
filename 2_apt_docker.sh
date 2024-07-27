#!/bin/bash
#launch this script from github
#wget  -q -O - https://raw.githubusercontent.com/yvan-allioux/linux-setup/main/2_apt_docker.sh | bash

#docker
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
apt-cache policy docker-ce
sudo apt install docker-ce -y
sudo usermod -aG docker ${USER}
sudo su - ${USER}

#Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/v2.24.6/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

#lazydocker       https://github.com/jesseduffield/lazydocker/releases/
wget https://github.com/jesseduffield/lazydocker/releases/download/v0.23.1/lazydocker_0.23.1_Linux_x86_64.tar.gz
tar -xvf lazydocker_*.tar.gz
sudo mv ./lazydocker /usr/bin
chmod +x /usr/bin/lazydocker
rm lazydocker_*.tar.gz LICENSE README.md


