#!/bin/bash

# copy kitty.conf and the kitty theme to kitty directory
cp kitty.conf ~/.config/kitty
cp rhel-theme.conf ~/.config/kitty

# make the directory needed to add micro colorschemes then copy the theme into it
mkdir -p  ~/.config/micro/colorschemes
cp micro-conf ~/.config/micro/colorschemes

mv bashrc .bashrc
cp .bashrc ~/.

echo "v micro editorju dj ctrl+e pa vpiÅ¡i set colorscheme rhel-theme"
