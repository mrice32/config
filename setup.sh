#!/usr/bin/env bash

USER_NAME=$(printf '%s' "${SUDO_USER:-$USER}")

# Should be run with sudo

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Non sudo commands
sudo -u $USER_NAME cp $DIR/.bashrc ~/
sudo -u $USER_NAME cp $DIR/.vimrc ~/

sudo -u $USER_NAME git clone https://github.com/magicmonty/bash-git-prompt.git ~/.bash-git-prompt

# Only works for mac and ubuntu for now
OS_IDENTIFIER=`uname`

# Update packages

if [ "$OS_IDENTIFIER" == "Darwin" ]; then
	echo "Mac Detected"
	port selfupdate
	port upgrade outdated
	port install nmap
else
    echo "Linux (Ubuntu) detected"
    apt-get update
    apt-get upgrade
    apt-get install nmap
fi
