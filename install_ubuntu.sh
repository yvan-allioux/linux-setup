#!/bin/bash

sudo apt update
sudo apt upgrade -y

#curl
sudo apt install curl -y
#git
sudo apt install git -y
#vim
sudo apt install vim -y
#micro
curl https://getmic.ro | bash
sudo mv ./micro /usr/bin

#Vscode

sudo apt-get install wget gpg
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
sudo sh -c 'echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm -f packages.microsoft.gpg
sudo apt install apt-transport-https
sudo apt update
sudo apt install code

#brave

sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/brave-browser-archive-keyring.gpg] https://brave-browser-apt-release.s3.brave.com/ stable main"|sudo tee /etc/apt/sources.list.d/brave-browser-release.list
sudo apt update
sudo apt install brave-browser

#github-desktop
wget -qO - https://apt.packages.shiftkey.dev/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/shiftkey-packages.gpg > /dev/null
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" > /etc/apt/sources.list.d/shiftkey-packages.list'
sudo apt update && sudo apt install github-desktop

#gnome extention
sudo apt install gnome-tweaks -y
sudo apt install gnome-shell-extensions -y
sudo apt install chrome-gnome-shell -y
#https://extensions.gnome.org/extension/4000/babar/

#grub-customizer
sudo add-apt-repository ppa:trebelnik-stefina/grub-customizer -y
sudo apt update
sudo apt install grub-customizer -y

#lazydocker
#https://github.com/jesseduffield/lazydocker
#lazydocker_0.20.0_Linux_x86_64
#sudo mv ./lazydocker /usr/bin


#docker
sudo apt update
sudo apt install apt-transport-https ca-certificates curl software-properties-common
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"
apt-cache policy docker-ce
sudo apt install docker-ce -y

sudo usermod -aG docker ${USER}
sudo su - ${USER}

#Docker Compose

sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

#zsh
sudo apt install zsh -y
chsh -s $(which zsh) #no root
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
cp .zshrc ~/.zshrc
