#!/bin/bash

sudo -v

# Finder Settings
echo "Setting Finder settings..."
defaults write com.apple.finder AppleShowAllFiles -bool true
defaults write NSGlobalDomain AppleShowAllExtensions -bool true
defaults write com.apple.finder ShowStatusBar -bool true
defaults write com.apple.finder ShowPathbar -bool true
defaults write com.apple.finder _FXShowPosixPathInTitle -bool true
defaults write com.apple.finder _FXSortFoldersFirst -bool true
defaults write com.apple.finder FXDefaultSearchScope -string "SCcf"
defaults write com.apple.finder FXEnableExtensionChangeWarning -bool false
defaults write com.apple.desktopservices DSDontWriteNetworkStores -bool true
defaults write com.apple.desktopservices DSDontWriteUSBStores -bool true
defaults write com.apple.finder FXPreferredViewStyle -string "Nlsv"
sudo chflags nohidden /Volumes

# Install Homebrew
echo "Installing Homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
eval "$(/opt/homebrew/bin/brew shellenv)"

# Install various Homebrew packages
echo "Installing Homebrew packages..."
brew install zsh eza node git yazi neovim clangd basedpyright ruff ripgrep fd make llvm zsh-autosuggestions zsh-syntax-highlighting lemonade btm portaudio pkg-config rust

echo "Installing casks..."
brew install --cask brave-browser
brew install --cask font-jetbrains-mono-nerd-font

echo "Configuring environment for Cargo..."
# Detect Apple Silicon vs Intel Homebrew paths for portaudio
if [[ -d "/opt/homebrew/opt/portaudio/lib/pkgconfig" ]]; then
  export PKG_CONFIG_PATH="/opt/homebrew/opt/portaudio/lib/pkgconfig:$PKG_CONFIG_PATH"
elif [[ -d "/usr/local/opt/portaudio/lib/pkgconfig" ]]; then
  export PKG_CONFIG_PATH="/usr/local/opt/portaudio/lib/pkgconfig:$PKG_CONFIG_PATH"
fi

# Install cargo packages
echo "Installing cargo crates..."
cargo install spotatui stylua

# Install ohmyzsh
RUNZSH=no sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Install NPM packages
echo "Installing NPM packages..."
npm install -g prettier typescript-language-server typescript vscode-langservers-extracted @tailwindcss/language-server
