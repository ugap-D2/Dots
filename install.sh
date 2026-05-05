#!/bin/bash

# copy kitty.conf and the kitty theme to kitty directory
cp kitty.conf ~/.config/kitty
cp rhel-theme.conf ~/.config/kitty
mkdir -p ~/Pictures/logos
cp logo/RH-logo.png ~/Pictures/logos

# make the directory needed to add micro colorschemes then copy the theme into it
mkdir -p  ~/.config/micro/colorschemes
cp rhel-theme.micro ~/.config/micro/colorschemes

cp .bashrc ~/

echo "to use the micro colorscheme you will need to run micro then do ctrl+e and type set colorscheme rhel-theme"
