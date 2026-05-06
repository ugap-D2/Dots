#!/bin/bash

# stops script if any command fails
set -e

RED="\e[31m"
GREEN="\e[92m"
MAGENTA="\e[95m"
YELLOW="\e[93m"
ENDCOLOR="\e[0m"

# determening the OS
echo -e "${GREEN}Checkhing the package manager in use...${ENDCOLOR}"
echo ""
packagesNeeded=(kitty micro picom eza bat)
if [ -x "$(command -v apk)" ];
then
    sudo apk add --no-cache "${packagesNeeded[@]}"
elif [ -x "$(command -v apt-get)" ];
then
    sudo apt-get install -y "${packagesNeeded[@]}"
elif [ -x "$(command -v dnf)" ];
then
    sudo dnf install -y "${packagesNeeded[@]}"
elif [ -x "$(command -v pacman)" ];
then
    sudo pacman -Su "${packagesNeeded[@]}"
else
echo -e "${RED}FAILED TO INSTALL PACKAGE: Package manager not found. You must manually install: kitty, micro, picom, eza, bat ${ENDCOLOR}"
fi

echo -e "${GREEN}Dependencies installed${ENDCOLOR}"
echo ""

# copy kitty.conf and the kitty theme to kitty directory
echo -e "${GREEN}Copying kitty configuration files to kitty directory...${ENDCOLOR}"
echo ""
cp kitty.conf ~/.config/kitty
cp rhel-theme.conf ~/.config/kitty
echo -e "${GREEN}Copying logo for kitty terminal...${ENDCOLOR}"
echo ""
mkdir -p ~/Pictures/logos
cp logo/RH-logo.png ~/Pictures/logos

# make the directory needed to add micro colorschemes then copy the theme into it
echo -e "${MAGENTA}Copying micro colorscheme to micros colorscheme directory...${ENDCOLOR}"
echo ""
mkdir -p  ~/.config/micro/colorschemes
cp rhel-theme.micro ~/.config/micro/colorschemes

# backup existing .bashrc if there is one present
if [ -f ~/.bashrc ]; then
    echo -e "${YELLOW}Backing up existing .bashrc to ~/.bashrc.backup${ENDCOLOR}"
    echo ""
    mv ~/.bashrc ~/.bashrc.backup
fi

# copy new .bashrc to home dir
echo -e "${YELLOW}Copying the new .bashrc file to the home directory${ENDCOLOR}"
echo ""
cp .bashrc ~/

echo -e "${MAGENTA}Micro theme installed${ENDCOLOR}"
echo -e "${MAGENTA}To enable it: open micro and press ctrl+e then type:${ENDCOLOR}"
echo -e "${MAGENTA}set colorscheme rhel-theme${ENDCOLOR}"

echo -e "${GREEN}The install ended sucesfully${ENDCOLOR}"
