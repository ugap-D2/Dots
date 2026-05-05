#!/bin/bash

# stops script if any command fails
set -e

# install all dependencies
echo "installing all dependencies..."
sudo dnf install -y kitty micro picom

# copy kitty.conf and the kitty theme to kitty directory
echo "copying kitty configuration files to kitty directory..."
cp kitty.conf ~/.config/kitty
cp rhel-theme.conf ~/.config/kitty
echo "copying logo for kitty terminal..."
mkdir -p ~/Pictures/logos
cp logo/RH-logo.png ~/Pictures/logos

# make the directory needed to add micro colorschemes then copy the theme into it
echo "copying colorscheme for micro editor..."
mkdir -p  ~/.config/micro/colorschemes
cp rhel-theme.micro ~/.config/micro/colorschemes

# backup existing .bashrc if there is one present
if [ -f ~/.bashrc ]; then
    echo "Backing up existing .bashrc to ~/.bashrc.backup"
    cp ~/.bashrc ~/.bashrc.backup
fi

# copy new .bashrc to home dir
echo "copying new .bashrc into home directory"
cp .bashrc ~/

echo "Micro theme installed."
echo "To enable it: open micro, press Ctrl+E, then type:"
echo "set colorscheme rhel-theme"
