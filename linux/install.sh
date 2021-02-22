#!/bin/bash

# Remove previous installations
sudo apt-get remove --purge ghc-8.4.4 cabal-install happy
rm -rf ~/.ghc ~/.cabal

# Install GHC
sudo apt-get install -y build-essential curl git libgmp-dev libffi-dev libncurses-dev libtinfo5 zlib1g-dev
curl --proto '=https' --tlsv1.2 -sSf https://get-ghcup.haskell.org | sh

ghcup install 8.6.5
ghcup set 8.6.5

ghc --version

# GHC Setup
cabal v2-update
cabal v2-install ghcid

# Determine Linux distro
# Credit: https://unix.stackexchange.com/questions/6345/how-can-i-get-distribution-name-and-version-number-in-a-simple-shell-script
if [ -f /etc/os-release ]; then
    # freedesktop.org and systemd
    . /etc/os-release
    OS=$NAME
    VER=$VERSION_ID
elif type lsb_release >/dev/null 2>&1; then
    # linuxbase.org
    OS=$(lsb_release -si)
    VER=$(lsb_release -sr)
elif [ -f /etc/lsb-release ]; then
    # For some versions of Debian/Ubuntu without lsb_release command
    . /etc/lsb-release
    OS=$DISTRIB_ID
    VER=$DISTRIB_RELEASE
elif [ -f /etc/debian_version ]; then
    # Older Debian/Ubuntu/etc.
    OS=Debian
    VER=$(cat /etc/debian_version)
elif [ -f /etc/SuSe-release ]; then
    # Older SuSE/etc.
    ...
elif [ -f /etc/redhat-release ]; then
    # Older Red Hat, CentOS, etc.
    ...
else
    # Fall back to uname, e.g. "Linux <version>", also works for BSD, etc.
    OS=$(uname -s)
    VER=$(uname -r)
fi

shopt -s nocasematch;

if [[ $OS =~ "debian" || "$OS" =~ "ubuntu" ]]; then
  DOWNLOAD_LINK = "https://code.visualstudio.com/sha/download?build=stable&os=linux-deb-x64"
else
  DOWNLOAD_LINK = "https://code.visualstudio.com/sha/download?build=stable&os=linux-rpm-x64"
fi

mkdir ./temp || true
curl -o ./temp/vscode-installation DOWNLOAD_LINK

if [[ $OS =~ "debian" || "$OS" =~ "ubuntu" ]]; then
  sudo dpkg -i ./temp/vscode-installation
else
  sudo rpm -i ./temp/vscode-installation
fi 

# Installing vscode extensions
code --install-extension haskell.vsix || ext install haskell.haskell
