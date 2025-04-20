#!/bin/bash

BASHRC=~/.bashrc
BANNER=~/.cool_banner
BANNER_URL="https://raw.githubusercontent.com/lovetogit/CLI_COOL_TEXT/refs/heads/main/cool_banner.txt"

# 1. Download banner if not already there
if [ ! -f "$BANNER" ]; then
    wget -O "$BANNER" "$BANNER_URL"
fi

# 2. Add clear, lolcat, PS1 only if not already added
grep -qxF "clear" "$BASHRC" || echo "clear" >> "$BASHRC"

grep -qxF "cat ~/.cool_banner | lolcat" "$BASHRC" || echo "cat ~/.cool_banner | lolcat" >> "$BASHRC"

# For PS1, we’ll check a keyword to avoid full regex pain
if ! grep -q "PS1='\\[\\e[1;35m\\]" "$BASHRC"; then
    echo "PS1='\\[\\e[1;35m\\]\\u@\\h \\[\\e[1;36m\\]\\w \\\$\\[\\e[0m\\] '" >> "$BASHRC"
fi
