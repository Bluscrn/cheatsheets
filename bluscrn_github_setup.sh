#!/bin/bash
#Created by Eric Dubois
#Spooned and modified by bluscrn

# start ssh-agent so that ssh keys work with git
eval `ssh-agent` 

set -e
##################################################################################################################
# Author 	: 	Eric Dubois
##################################################################################################################
#
#   DO NOT JUST RUN THIS. EXAMINE AND JUDGE. RUN AT YOUR OWN RISK.
#
##################################################################################################################
# change into your name and email.

git init
git config --local user.name "Bluscrn"
git config --local user.email "server.brandon.glenn3@gmail.com"
sudo git config --system core.editor rsub
# git config --global credential.helper cache
# git config --global credential.helper 'cache --timeout=25000'
git config --local push.default simple


echo "################################################################"
echo "###################    T H E   E N D      ######################"
echo "################################################################"