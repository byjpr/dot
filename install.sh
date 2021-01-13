#!/usr/bin/env bash

set -e

echo "👋  Deep breaths, everything will (probably) be fine!"

# Ask for the administrator password upfront
sudo -v

# Set up symbolic links for ZSH and Git pointing to this cloned repo
ln -sf "$HOME"/.dotfiles/zsh/.zshrc "$HOME"/.zshrc
ln -sf "$HOME"/.dotfiles/git/.gitconfig "$HOME"/.gitconfig
ln -sf "$HOME"/.dotfiles/git/.gitignore_global "$HOME"/.gitignore_global
mkdir -p "$HOME"/.ssh
ln -sf "$HOME"/.dotfiles/ssh/.ssh/config "$HOME"/.ssh/config

# https://github.com/ohmyzsh/ohmyzsh/issues/6835#issuecomment-390187157
chmod 755 /usr/local/share/zsh
chmod 755 /usr/local/share/zsh/site-functions

# Get Oh My ZSH up and running
if [ ! -e ~/.oh-my-zsh ]; then
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
fi

# Use Git submodules to get OMZ plugins
git submodule update --init --recursive

# Make ZSH the default shell environment (maybe unnecessary on Catalina?)
# shellcheck disable=SC2230
chsh -s "$(which zsh)"

if [ "$(uname)" == "Darwin" ]; then
  # shellcheck disable=SC1091
  source ./macos/macos.sh
else
  echo ""
  echo "This isn't a Mac, so we're all done here!"
  echo "Logout/restart now for the full effects."
  exit 0
fi
