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
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting

#si on a pas la posibilité de faire des git clone
#cd
#cd Download
#unzip zsh-syntax-highlighting-master.zip
#unzip zsh-autosuggestions-master.zip
#mv zsh-autosuggestions-master ~/.zsh/zsh-autosuggestions
#mv zsh-syntax-highlighting-master ~/.zsh/zsh-syntax-highlighting
#rm zsh-syntax-highlighting-master.zip
#rm zsh-autosuggestions-master.zip

curl https://raw.githubusercontent.com/yvan-allioux/linux-setup/main/.zshrc > ~/.zshrc




docker run -d --network=host --add-host=host.docker.internal:host-gateway -v ollama-webui:/app/backend/data -e OLLAMA_API_BASE_URL=http://localhost:11434/api --name ollama-webui --restart always ghcr.io/ollama-webui/ollama-webui:main
docker run -d --network=host -v ollama-webui:/app/backend/data -e OLLAMA_API_BASE_URL=http://127.0.0.1:11434/api --name ollama-webui --restart always ghcr.io/ollama-webui/ollama-webui:main
