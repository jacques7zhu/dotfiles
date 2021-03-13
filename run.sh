#!/bin/bash
PWD=$(pwd)
ln -s $PWD/vimrc ~/.vimrc
ln -s $PWD/gitconfig ~/.gitconfig
ln -s $PWD/config.fish ~/.config/fish/config.fish
mkdir -p ~/.config/nvim/ && ln -s $PWD/init.vim ~/.config/nvim/init.vim
ln -s $PWD/ctags ~/.ctags
ln -s $PWD/tmux.conf ~/.tmux.conf
ln -s $PWD/tmux ~/.tmux
