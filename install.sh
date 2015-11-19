#!/bin/bash
DOTFILES=$HOME/dotfiles

# Run this script to install all the dependencies and create symlinks in $HOME 
# after cloning the dotfiles repo

# Update git submodules
echo "Updating git submodules ..."
cd $DOTFILES
git submodule update --init --recursive

# Install cmake
echo "Installing cmake to satisfy some dependencies"
sudo dnf -y install cmake

# Install node, build dependencies and nvm
echo "Installing build dependencise, node and nvm"
wget -qO- https://gist.githubusercontent.com/trajakovic/ad9f91776dea3b495db0/raw/fedora-install-nodejs.sh|sudo bash
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash

# Install ruby
echo "Installing ruby and ruby-gems"
sudo dnf -y install ruby

# Installing additional software
echo "Installing tmux, taskwarrior"
sudo dnf -y install tmux
sudo dnf -y install task

# Installing neovim
sudo dnf -y install dnf-plugins-core
sudo dnf -y copr enable dperson/neovim
sudo dnf -y install neovim

# For the lulz
echo "Install fortune and cowsay"
sudo dnf -y install fortune-mod cowsay

# Install zsh and oh-my-zsh
echo "Installing zsh"
sudo dnf -y install zsh
echo "Installing oh-my-zsh"
wget --no-check-certificate http://install.ohmyz.sh -O - | sh
echo "Setting zsh as default shell"
sudo chsh -s /bin/zsh
echo "Symlink .zshrc files to ~"
ln -sF $DOTFILES/.zshrc $HOME/.zshrc
ln -s $DOTFILES/.zshenv $HOME/.zshenv
ln -s $DOTFILES/.zshrc.bundles $HOME/.zshrc.bundles
ln -s $DOTFILES/.aliases $HOME/.aliases

# Get zsh and autogen plugin dependencies
echo "Installing autojump"
sudo dnf -y install autojump-zsh
echo "Installing silversearcher"
sudo dnf -y install the_silver_searcher

# Linking taskwarrior files. Make sure that dropbox is installed and synced
echo "Syncing taskwarrior data. Make sure dropbox is synced"
ln -sF $DOTFILES/.taskrc $HOME/.taskrc
ln -sF $HOME/Dropbox/taskwarrior/backlog.data $HOME/.task/backlog.data
ln -sF $HOME/Dropbox/taskwarrior/completed.data $HOME/.task/completed.data
ln -sF $HOME/Dropbox/taskwarrior/pending.data $HOME/.task/pending.data
ln -sF $HOME/Dropbox/taskwarrior/undo.data $HOME/.task/undo.data

ln -sF $HOME/Dropbox/taskwarrior/backlog.data $HOME/.task/backlog.data
ln -sF $HOME/Dropbox/taskwarrior/backlog.data $HOME/.task/backlog.data

ln -sF $HOME/Dropbox/taskwarrior/backlog.data $HOME/.task/backlog.data
ln -sF $HOME/Dropbox/taskwarrior/backlog.data $HOME/.task/backlog.data



