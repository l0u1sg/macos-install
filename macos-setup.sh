#! /usr/bin/env bash
# Setup script for setting up a new macos machine

# Check if system is macos
if [ "$(uname)" != "Darwin" ]; then
    echo "Sorry bro, this script is only for macos"
    exit 1
fi

echo "Starting setup"

# Check if xcode CLI is installed
if ! xcode-select --print-path &> /dev/null; then
    echo "Installing xcode CLI"
    xcode-select --install &> /dev/null
    # Wait until xcode CLI is installed
    until xcode-select --print-path &> /dev/null; do
        sleep 5
    done
    echo "Xcode CLI installed"
else
    echo "Xcode CLI already installed"
fi

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

# Check if packages are installed
for package in ${PACKAGES[@]}; do
    if brew list $package > /dev/null 2>&1; then
        echo "$package already installed"
    else
        echo "Installing $package"
        brew install $package
    fi
done

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

# Check if cask apps are installed
for cask in ${CASKS[@]}; do
    if brew list --cask $cask > /dev/null 2>&1; then
        echo "$cask already installed"
    else
        echo "Installing $cask"
        brew install --cask $cask
    fi
done

echo "Macbook setup complete"