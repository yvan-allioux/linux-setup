#!/bin/bash

#sudo apt update ; sudo apt upgrade -y ; sudo apt install git vim curl zsh -y
#git clone https://github.com/yvan-allioux/linux-setup
#cd linux-setup ; chmod +x wsl_install.sh
#./wsl_install.sh

echo "---update---"

#curl
sudo apt install curl -y

echo "---vim---"

#vim
sudo apt install vim -y

echo "---micro---"

#micro
curl https://getmic.ro | bash
sudo mv ./micro /usr/bin

echo "---docker---"

#docker
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
apt-cache policy docker-ce
sudo apt install docker-ce -y
sudo usermod -aG docker ${USER}
sudo su - ${USER}

echo "---docker compose---"

#Docker Compose
sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

echo "---zsh---"

#zsh
sudo apt install zsh -y
#launch one time zsh to create .zshrc
chsh -s $(which zsh) #no root
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
cp .zshrc ~/.zshrc
