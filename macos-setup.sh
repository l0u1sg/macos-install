#! /usr/bin/env bash
# Setup script for setting up a new macos machine

echo "Starting setup"

# Install xcode CLI
xcode-select --install

# Install homebrew
# Check if homebrew is installed
if test ! $(which brew); then
    echo "Installing homebrew"
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Update homebrew
brew update

PACKAGES=(
    nvm
    git
    git-lfs
    wget
    zsh
)

echo "Installing packages..."
brew install ${PACKAGES[@]}

# Link readline
brew link --force readline

echo "Cleaning up..."
brew cleanup

echo "Installing cask..."

CASKS=(
    iterm2
    visual-studio-code
    1password
    altserver
    appcleaner
    discord
    iina
    notion
    keka
    termius
    arc
    swish
    nordvpn
)

echo "Installing cask apps..."
brew install --cask ${CASKS[@]}

echo "Macbook setup complete"