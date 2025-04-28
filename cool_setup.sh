#!/bin/bash

BASHRC=~/.bashrc
BANNER=~/.cool_banner.txt
BANNER_URL="https://raw.githubusercontent.com/lovetogit/CLI_COOL_TEXT/refs/heads/main/cool_banner.txt"

# 0. Ensure wget is installed
if ! command -v wget &> /dev/null; then
    echo "wget not found. Installing..."

    if [ -f /etc/debian_version ]; then
        sudo apt update && sudo apt install -y wget
    elif [ -f /etc/redhat-release ]; then
        sudo yum install -y wget
    elif [ -f /etc/arch-release ]; then
        sudo pacman -Sy wget --noconfirm
    else
        echo "Unsupported distro. Please install wget manually."
    fi
fi

# 1. Install lolcat if not already installed
if ! command -v lolcat &> /dev/null; then
    echo "lolcat not found. Installing..."

    if [ -f /etc/debian_version ]; then
        sudo apt update && sudo apt install -y lolcat
    elif [ -f /etc/redhat-release ]; then
        sudo yum install -y ruby
        sudo gem install lolcat
    elif [ -f /etc/arch-release ]; then
        sudo pacman -Sy lolcat --noconfirm
    else
        echo "Unsupported distro. Please install lolcat manually."
    fi
fi

# 2. Download banner if not already there
if [ ! -f "$BANNER" ]; then
    wget -O "$BANNER" "$BANNER_URL"
fi

# 3. Add interactive shell block if not already present
if ! grep -q "cat ~/cool_banner.txt | lolcat" "$BASHRC"; then
    echo "" >> "$BASHRC"
    echo "# Only run if it's an interactive shell" >> "$BASHRC"
    echo "if [[ \$- == *i* ]]; then" >> "$BASHRC"
    echo "  clear" >> "$BASHRC"
    echo "  cat ~/cool_banner.txt | lolcat" >> "$BASHRC"
    echo "fi" >> "$BASHRC"
fi

# 4. Add PS1 if not already present
if ! grep -q "PS1='\\[\\e[1;35m\\]" "$BASHRC"; then
    echo "PS1='\\[\\e[1;35m\\]\\u@\\h \\[\\e[1;36m\\]\\w \\\$\\[\\e[0m\\] '" >> "$BASHRC"
fi
