#!/usr/bin/env bash

USER_NAME=$(printf '%s' "${SUDO_USER:-$USER}")

# Should be run with sudo

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Non sudo commands
sudo -u $USER_NAME cp $DIR/.bash_profile ~/
sudo -u $USER_NAME cp $DIR/.bashrc ~/
sudo -u $USER_NAME cp $DIR/.vimrc ~/

# Move so that the clone will work initially, and then overwrite whatever currently exists if anything
INITIAL_DIR_NAME=~/bash-git-prompt
sudo -u $USER_NAME git clone https://github.com/magicmonty/bash-git-prompt.git $INITIAL_DIR_NAME
sudo -u $USER_NAME mv $INITIAL_DIR_NAME ~/.bash-git-prompt

# Only works for mac and ubuntu for now
OS_IDENTIFIER=`uname`

# Update packages

if [ "$OS_IDENTIFIER" == "Darwin" ]; then
	echo "Mac Detected"
	port selfupdate
	port upgrade outdated
	port install nmap
    ln -s /System/Library/PrivateFrameworks/Apple80211.framework/Versions/Current/Resources/airport /usr/local/bin/airport
    easy_install pip
else
    echo "Linux (Ubuntu) detected"
    apt-get update
    apt-get upgrade
    apt-get install nmap
    apt-get install python-pip
fi

pip install --upgrade pip
