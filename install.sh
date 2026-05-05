#!/bin/bash
set -e

sudo dnf install kitty micro picom

# copy kitty.conf and the kitty theme to kitty directory
cp kitty.conf ~/.config/kitty
cp rhel-theme.conf ~/.config/kitty
mkdir -p ~/Pictures/logos
cp logo/RH-logo.png ~/Pictures/logos

# make the directory needed to add micro colorschemes then copy the theme into it
mkdir -p  ~/.config/micro/colorschemes
cp rhel-theme.micro ~/.config/micro/colorschemes

cp ~/.bashrc ~/.bashrc_backup
cp .bashrc ~/

echo "Micro theme installed."
echo "To enable it: open micro, press Ctrl+E, then type:"
echo "set colorscheme rhel-theme"
