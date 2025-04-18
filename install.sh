#!/bin/bash

# (C) Ilya Putilin @ 42POST
# https://github.com/fantopop/

# Script destination folder
SCRIPT_PATH="/Library/Scripts/Login/"

# Text colors
GREEN='\033[0;32m'
RED='\033[0;31m'
NC='\033[0m'

function install()
{
    # Read Telegram Bot Token from user
    read -p "Enter your Telegram Bot Token: " TELEGRAM_BOT_TOKEN
    # Read Telegram Channel ID from user
    read -p "Enter your Telegram Group Chat ID: " CHAT_ID

    # Download login/logout shell script an LaunchAgent plist
    curl -LJO https://raw.githubusercontent.com/fantopop/login-logout-notifications/refs/heads/main/login.sh
    curl -LJO https://raw.githubusercontent.com/fantopop/login-logout-notifications/refs/heads/main/ru.42post.login.plist

    # Insert into login.sh
    sed -i '' '16s/^/TELEGRAM_BOT_TOKEN="'$TELEGRAM_BOT_TOKEN'"\'$'\n/g' login.sh
    sed -i '' '21s/^/CHAT_ID="'$CHAT_ID'"\'$'\n/g' login.sh

    # Assign necessary permissions
    sudo chown root:wheel login.sh
    sudo chmod 755 login.sh
    sudo chmod a+x login.sh
    sudo chown root:wheel ru.42post.login.plist
    sudo chmod 755 ru.42post.login.plist

    # Create script folder if needed
    if [ ! -d "$SCRIPT_PATH" ]; then
    printf "\nCreating script folder..."
    printf "${GREEN}$SCRIPT_PATH${NC}\n"
    sudo mkdir $SCRIPT_PATH
    fi

    # Move the script
    printf "\nMoving ${GREEN}login.sh${NC} script to destination folder...\n"
    sudo mv login.sh $SCRIPT_PATH

    # Install the agent
    printf "\nInstalling agent: ${GREEN}/Library/LaunchAgents/ru.42post.login.plist${NC}...\n"
    sudo mv ru.42post.login.plist "/Library/LaunchAgents"
    launchctl load -w /Library/LaunchAgents/ru.42post.login.plist
    printf "\nDONE!"
    exit 0
}

function uninstall()
{
    # Stop the agent
    echo "Unloading agent..."
    launchctl unload -w /Library/LaunchAgents/ru.42post.login.plist
    # Remove the agent
    echo "Removing agent..."
    sudo rm -f /Library/LaunchAgents/ru.42post.login.plist
    # Remove script file
    echo "Removing script file..."
    sudo rm -f rm $SCRIPT_PATH/login.sh
    # Remove script folder if empty
    echo "Removing script folder if empty..."
    sudo rm -d $SCRIPT_PATH
    echo "Done!"
}

echo "Install / uninstall Telegram notifications for user login / logout on macOS"
echo "Choose your action:"
echo "1. Install"
echo "2. Uninstall"
echo "3. Quit"
read USER_INPUT

case $USER_INPUT in
    "1") install;;
    "2") uninstall;;
    *) exit 0
esac
