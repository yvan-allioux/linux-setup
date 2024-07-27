#!/bin/bash
#wget  -q -O - https://raw.githubusercontent.com/yvan-allioux/linux-setup/main/cyberdeck/apt_and_35LCD.sh | bash
sudo apt update 
sudo apt upgrade -y 
sudo apt install curl git vim zsh -y 

curl https://getmic.ro | bash
sudo mv ./micro /usr/bin

sudo rm -rf LCD-show
git clone https://github.com/goodtft/LCD-show.git
chmod -R 755 LCD-show
cd LCD-show/ && sudo ./LCD35-show

#cd LCD-show/ && sudo ./rotate.sh 180
