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
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
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

# Ask user if they want to add install apps to dock
echo "Do you want to add apps to dock? (y/n)"
read -r response
if [[ $response =~ ^([yY][eE][sS]|[yY])$ ]]; then
    # Check if dockutil is installed
    if ! brew list dockutil > /dev/null 2>&1; then
        echo "Installing dockutil"
        brew install dockutil
    fi

    echo "Adding apps to dock"
    # Add apps to dock
    dockutil --no-restart --add "/Applications/Visual Studio Code.app"
    dockutil --no-restart --add "/Applications/iTerm.app"
    dockutil --no-restart --add "/Applications/1Password 7.app"
    dockutil --no-restart --add "/Applications/Notion.app"
    dockutil --no-restart --add "/Applications/Discord.app"
    dockutil --no-restart --add "/Applications/Arc.app"
    killall Dock
fi

echo "Macbook setup complete"