#launch this script from github
#wget  -q -O - https://raw.githubusercontent.com/yvan-allioux/linux-setup/main/1_apt_essential.sh | bash

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

#zsh setup
sudo apt install zsh -y
chsh -s $(which zsh) #no root
git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
curl https://raw.githubusercontent.com/yvan-allioux/linux-setup/main/.zshrc > ~/.zshrc


