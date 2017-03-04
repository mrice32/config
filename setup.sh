#!/usr/bin/env bash


DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

cp $DIR/.bashrc ~/
cp $DIR/.vimrc ~/

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
