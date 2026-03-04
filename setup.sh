#!/usr/bin/env bash
if command -v brew &>/dev/null; then
    brew bundle --file=~/dotfiles/Brewfile

elif command -v apt &>/dev/null; then
    sudo apt update
    sudo apt install -y $(awk '{print $1}' ~/dotfiles/packages.list)

elif command -v pacman &>/dev/null; then
    sudo pacman -Syu --needed - < ~/dotfiles/pkglist.txt
fi

ln -sf ~/dotfiles/.zshrc ~/.zshrc
ln -sf ~/dotfiles/.gitconfig ~/.gitconfig
