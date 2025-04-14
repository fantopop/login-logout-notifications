# macOS LaunchAgent to send login / logout notifications using a Telegram bot

## Setup

1. Register a [Telegram bot](https://core.telegram.org/bots/tutorial). You will recieve a `TELEGRAM_BOT_TOKEN` upon registration.
2. [Get](https://gist.github.com/nafiesl/4ad622f344cd1dc3bb1ecbe468ff9f8a) a `CHAT_ID` of the group where you want the bot to send notifications.
3. Download [install.sh](https://raw.githubusercontent.com/fantopop/login-logout-notifications/refs/heads/main/install.sh) script somewhere on your Mac (e.g. to the `~/Downloads/ folder`).
4. Open Terminal.
5. Grant execute permissions to the `install.sh` script:

        chmod a+x ~/Downloads/install.sh
   
7. Run:
   
        ~/Downloads/install.sh
   
9. Follow onscreen instructions. Whenever asked, enter administrators password (it's necessary as `/Library/LaunchAgents/` folder is usually read-only for standard users).

When needed, uninstall the agent with the same script using a corresponding option.

## Acknowlegments
- [macos-script-login-logout script](https://github.com/christophecvr/macos-script-login-logout) by [christophecvr](https://github.com/christophecvr)
- [macosx-script-boot-shutdown](https://github.com/freedev/macosx-script-boot-shutdown/tree/master) by [freedev](https://github.com/freedev)
