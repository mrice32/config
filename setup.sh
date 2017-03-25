#!/usr/bin/env bash

USER_NAME=$(printf '%s' "${SUDO_USER:-$USER}")

# Should be run with sudo

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Non sudo commands
sudo -u $USER_NAME cp $DIR/.bash_profile ~/
sudo -u $USER_NAME cp $DIR/.bashrc ~/
sudo -u $USER_NAME cp $DIR/.vimrc ~/
sudo -u $USER_NAME cp $DIR/.git-prompt-colors.sh ~/

# Move so that the clone will work initially, and then overwrite whatever currently exists if anything
INITIAL_DIR_NAME=~/bash-git-prompt
FINAL_DIR_NAME=~/.bash-git-prompt
rm -rf $INITIAL_DIR_NAME
sudo -u $USER_NAME git clone https://github.com/magicmonty/bash-git-prompt.git $INITIAL_DIR_NAME
rm -rf $FINAL_DIR_NAME
sudo -u $USER_NAME mv $INITIAL_DIR_NAME $FINAL_DIR_NAME

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
    apt-get dist-upgrade
    apt-get install nmap
    apt-get install python-pip
fi

pip install --upgrade pip

# Set up python virtualenv for local package installation
pip install virtualenv

VIRTUAL_ENV_DIR=~/base.env
if [ ! -d "$VIRTUAL_ENV_DIR" ]; then
    sudo -u $USER_NAME virtualenv $VIRTUAL_ENV_DIR --no-site-packages
    chown -R $USER_NAME $VIRTUAL_ENV_DIR
    chmod u+rwx -R $VIRTUAL_ENV_DIR
    chmod a+rx -R $VIRTUAL_ENV_DIR
fi


