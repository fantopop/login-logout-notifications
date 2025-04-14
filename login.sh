#!/bin/bash

# Author christophecvr christophevanr@gmail.com
# Based on boot-shutdown script of:
# Vincenzo D'Amore v.damore@gmail.com
# Adapted to work as user Launchagent.
# 2024/01/12

# (C) Ilya Putilin @ 42POST
# Adapted to send Telegram messages using Bot

# Variables

# Enter your Telegram Bot Token or use install.sh
# TELEGRAM_BOT_TOKEN="YOUR_BOT_TOKEN"

# Enter your Telegram Chat ID or use install.sh
# Channel ID
# CHAT_ID="YOUR CHAT_ID"

# Get hostname
HOSTNAME=$(hostname -s)
# Get username
USERNAME=$(whoami)

trap userlogout SIGTERM

function userlogout()
{
	# Send logout notification
	# Set the message text
	MESSAGE="User [$USERNAME] logged out from [$HOSTNAME]"

	# Use the curl command to send the message
	curl -s -X POST \
	--data "chat_id=$CHAT_ID" \
	--data "text=$MESSAGE" \
	--data "parse_mode=HTML" \
	https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage
	exit 0
}

function userlogin()
{
	# Send login notification
	# Set the message text
	MESSAGE="User [$USERNAME] logged in to [$HOSTNAME]"

	# Use the curl command to send the message
	curl -s -X POST \
	--data "chat_id=$CHAT_ID" \
	--data "text=$MESSAGE" \
	--data "parse_mode=HTML" \
	https://api.telegram.org/bot$TELEGRAM_BOT_TOKEN/sendMessage

	tail -f /dev/null &
	wait $!
}

userlogin;
