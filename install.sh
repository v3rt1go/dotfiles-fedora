#!/bin/bash
DOTFILES=$HOME/dotfiles

# Run this script to install all the dependencies and create symlinks in $HOME 
# after cloning the dotfiles repo

# Update git submodules
echo "Updating git submodules ..."
cd $DOTFILES
git submodule update --init --recursive

# Install powerline fonts
echo "Installing powerline fonts ..."
source $DOTFILES/fonts/install.sh

# Install cmake and xclip
echo "Installing cmake to satisfy some dependencies"
sudo dnf -y install cmake
sudo dnf -y install xclip

# Install node, build dependencies and nvm
echo "Installing build dependencise, node and nvm"
wget -qO- https://gist.githubusercontent.com/trajakovic/ad9f91776dea3b495db0/raw/fedora-install-nodejs.sh|sudo bash
curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.29.0/install.sh | bash

# Install nvm stable node and use default
echo "Installing latest stable release of node with nvm and setting it default"
nvm install stable
nvm use stable
nvm alias default stable

# Install ruby
echo "Installing ruby and ruby-gems"
sudo dnf -y install ruby

# Installing additional software
echo "Installing tmux, taskwarrior"
sudo dnf -y install tmux
sudo dnf -y install task

# Install tmux plugins
echo "Setting up tmux plugins"
git clone https://github.com/tmux-plugins/tpm $HOME/.tmux/plugins/tpm
git clone https://github.com/erikw/tmux-powerline.git $HOME/.tmux/plugin/tmux-powerline

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

# Install ctags and add npm musthaves
echo "Install ctags and other npm tools"
sudo dnf -y install ctags-etags
npm install -g git+https://github.com/ramitos/jsctags.git
npm install -g tern

# Setup eslint with bable support
echo "Install eslint with babel-eslint"
npm install -g eslint
npm install -g babel
npm install -g babel-eslint
npm install -g html2jade

# Linking taskwarrior files. Make sure that dropbox is installed and synced
echo "Syncing taskwarrior data. Make sure dropbox is synced"
ln -sF $DOTFILES/.taskrc $HOME/.taskrc
ln -sF $HOME/Dropbox/taskwarrior/backlog.data $HOME/.task/backlog.data
ln -sF $HOME/Dropbox/taskwarrior/completed.data $HOME/.task/completed.data
ln -sF $HOME/Dropbox/taskwarrior/pending.data $HOME/.task/pending.data
ln -sF $HOME/Dropbox/taskwarrior/undo.data $HOME/.task/undo.data

echo "Setting up tmux configs and plugins"
ln -sF $DOTFILES/.tmux.conf $HOME/.tmux.conf
ln -sF $DOTFILES/.editorconfig $HOME/.editorconfig

# Setup editor theme - for gnome terminal
echo "Setting up editor theme for gnome terminal"
ln -sf $DOTFILES/base16-eighties.dark.sh $HOME/.config/base16-eighties.dark.sh
source $HOME/.config/base16-eighties.dark.sh

# Initialize tmux plugin
echo "Initializing tmux conf file"
tmux source $HOME/.tmux.conf

# Configuring nvim
echo "Linking vim config files"
ln -sf $DOTFILES/.vimrc $HOME/.vimrc
#ln -sf $DOTFILES/.vimrc.before $HOME/.vimrc.before
#ln -sf $DOTFILES/.vimrc.before.local $HOME/.vimrc.before.local
ln -sf $DOTFILES/.vimrc.bundles $HOME/.vimrc.bundles
#ln -sf $DOTFILES/.vimrc.bundles.default $HOME/.vimrc.bundles.local
#ln -sf $DOTFILES/.vimrc.local $HOME/.vimrc.local
echo "Installing vim-plug for plugin management"
mkdir $HOME/.vim
curl -fLo $HOME/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

echo "Configuring neovim files and plugins"
mkdir -p ${XDG_CONFIG_HOME:=$HOME/.config}
ln -s ~/.vim $XDG_CONFIG_HOME/nvim
ln -s ~/.vimrc $XDG_CONFIG_HOME/nvim/init.vim

# Source .zshrc
echo "All done ... Reloading zsh ..."
source $HOME/.zshrc
