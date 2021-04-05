#!/bin/bash
PWD=$(pwd)
mkdir -p ~/.config/nvim
mkdir -p ~/.config/fish
mkdir -p ~/.docker
ln -sf $PWD/vimrc ~/.vimrc
ln -sf $PWD/gitconfig ~/.gitconfig
ln -sf $PWD/config.fish ~/.config/fish/config.fish
ln -sf $PWD/init.vim ~/.config/nvim/init.vim
ln -sf $PWD/ctags ~/.ctags
ln -sf $PWD/tmux.conf ~/.tmux.conf
ln -sf $PWD/tmux ~/.tmux
ln -sf $PWD/docker_config.json ~/.docker/config.json
