#!/bin/bash
echo "COMPOSE SCRIPT INSTALLER"

echo "Create folder ~/bin and add to PATH"

echo "Create ~/bin"
cd ~/ && mkdir bin

echo "Backup ~/.bash_profile to ~/.bash_profile.compose.backup"
cp ~/.bash_profile ~/.bash_profile.compose.backup
touch ~/.bash_profile

echo "Add ~/bin to PATH"
echo 'PATH=$PATH:$HOME/bin' >> ~/.bash_profile 

echo "Reload ~/.bash_profile"
source ~/.bash_profile

echo "Download & Install app compose (benoitlavorata)"
cd ~/bin
rm compose.sh
rm helpers.sh
wget https://raw.githubusercontent.com/benoitlavorata/compose/master/helpers.sh && chmod +x helpers.sh
wget https://raw.githubusercontent.com/benoitlavorata/compose/master/compose.sh && chmod +x compose.sh
mv compose.sh app
echo "Installed the app !"

echo "Type exit, login again, then you can now use the command: app <APP_NAME>"