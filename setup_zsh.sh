#!/bin/bash

# 1. Update and Install Dependencies
echo "--> Updating package lists and installing Zsh/Git..."
sudo apt update && sudo apt install -y zsh git curl fonts-powerline

# 2. Install Oh My Zsh (Unattended)
# The --unattended flag prevents it from dropping you into the shell immediately, allowing the script to continue.
if [ -d "$HOME/.oh-my-zsh" ]; then
    echo "--> Oh My Zsh is already installed. Skipping..."
else
    echo "--> Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# 3. Install Plugins (Autosuggestions & Syntax Highlighting)
ZSH_CUSTOM=${ZSH_CUSTOM:-~/.oh-my-zsh/custom}

echo "--> Installing zsh-autosuggestions..."
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]; then
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM}/plugins/zsh-autosuggestions
else
    echo "    (Already installed)"
fi

echo "--> Installing zsh-syntax-highlighting..."
if [ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]; then
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM}/plugins/zsh-syntax-highlighting
else
    echo "    (Already installed)"
fi

# 4. Configure .zshrc
# We use sed to search for the plugins line and replace it to include our new plugins.
echo "--> Configuring .zshrc..."
sed -i 's/plugins=(git)/plugins=(git zsh-autosuggestions zsh-syntax-highlighting)/' ~/.zshrc

# 5. Change Default Shell
echo "--> Changing default shell to Zsh..."
# Check if zsh is already the default shell
if [ "$SHELL" != "$(which zsh)" ]; then
    chsh -s $(which zsh)
    echo "    Default shell changed. You may need to log out and back in."
else
    echo "    Zsh is already the default shell."
fi

echo "--> Setup Complete! Restart your terminal or type 'zsh' to start."
