#!/bin/bash
#launch this script from github
#wget  -q -O - https://raw.githubusercontent.com/yvan-allioux/linux-setup/main/1_apt_essential.sh | bash

#sudo apt update && sudo apt upgrade -y && sudo apt full-upgrade -y && sudo apt autoremove -y

sudo apt update && sudo apt upgrade -y

#curl git vim
sudo apt install curl git vim -y

#github 
#sudo apt install gh -y

#micro
curl https://getmic.ro | bash
sudo mv ./micro /usr/bin

#zsh setup
sudo apt install zsh -y
chsh -s $(which zsh) #no root
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
curl https://raw.githubusercontent.com/yvan-allioux/linux-setup/main/.zshrc > ~/.zshrc


