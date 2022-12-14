#!/bin/bash
# LxDERS
# LINUX DESKTOP ENVIRONMENT RESTORATION SCRIPT
# DEVELOPER TOOLS
# FOR UBUNTU FLAVOURED DISTRIBUTIONS

DIV="███████ "
IFS=''

echo "██      ██   ██ ██████  ███████ ██████  ███████ "
echo "██       ██ ██  ██   ██ ██      ██   ██ ██      ``"
echo "██        ███   ██   ██ █████   ██████  ███████ "
echo "██       ██ ██  ██   ██ ██      ██   ██      ██ "
echo "███████ ██   ██ ██████  ███████ ██   ██ ███████ "
echo "                                                "
echo "$DIV LxDERS Linux Desktop Environment Restoration Script"

echo "$DIV To setup your GIT credentials we need some details"
echo "$DIV Please enter the e-mail you want to associate with GIT"
read -p "$DIV > " GIT_EMAIL
echo "$DIV Please enter the full name you want to associate with GIT"
read -p "$DIV Please enter the full name you want to associate with GIT > " GIT_NAME

echo "$DIV Performing necessary system update / upgrade"
sudo apt-get update
sudo apt-get upgrade -y

# Development machine specific
echo "$DIV Installing core dev tools"
sudo apt-get install curl make -y

echo "$DIV Installing GIT"
sudo apt-get install git -y

echo "$DIV Setting up GIT Config"
git config --global user.email "$GIT_EMAIL"
git config --global user.name "$GIT_NAME"
git config --global init.defaultBranch main
git config --global pull.rebase true
git config --global push.default current

echo "$DIV Installing IDEs"
sudo snap install webstorm --classic
sudo snap install pycharm-community --classic

echo "$DIV Installing Insomnia"
curl -o insomnia.deb -L https://updates.insomnia.rest/downloads/ubuntu/latest?&app=com.insomnia.app&source=website
sudo apt install ./insomnia.deb -y

echo "$DIV Installing n, node, npm"
curl -L https://git.io/n-install | bash

echo "Add global npm packages"
npm i -g prettier
npm i -g nodemon

echo "$DIV Setting up SSH keys..."
SSH_KEYS="ssh-add "
SEARCH_SSH_KEYS=`find ~/.ssh -type f \( ! -iname "*.pub" ! -iname "known_hosts*"  \)`
for SSH_KEY in $SEARCH_SSH_KEYS
do
SSH_KEYS+="$SSH_KEY "
done

# Modify BASH shell
cat << EOF >> ~/.bashrc

###
# Added by LxDERS
###

# All python commands get relayed to python3
alias python='python3'

# Target all private SSH keys
$SSH_KEYS

###
# End of LxDERS additions
###
EOF

# Remove unneeded packages
sudo apt-get autoremove
