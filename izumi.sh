#!/bin/bash

# Step 1: Update and upgrade the system
echo "Updating and upgrading the system..."
apt update && apt upgrade -y

# Step 2: Install necessary packages
echo "Installing required packages..."
pkg install wget openssl-tool proot -y
hash -r

# Step 3: Download and run the Ubuntu installer
echo "Downloading Ubuntu installer..."
wget https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Scripts/Installer/Ubuntu/ubuntu.sh
bash ubuntu.sh

# Step 4: Start Ubuntu
echo "Starting Ubuntu..."
./start-ubuntu.sh

# Step 5: Update and install additional packages
echo "Updating and installing additional packages..."
apt update && apt upgrade -y
apt install sudo -y
sudo apt install ffmpeg imagemagick yarn git curl -y

# Step 6: Install Node.js
echo "Installing Node.js..."
sudo apt -y remove nodejs
curl -fsSl https://deb.nodesource.com/setup_lts.x | sudo bash - 
sudo apt -y install nodejs

# Step 7: Clone the bot repository
echo "Cloning the bot repository..."
git clone https://github.com/sataniceypz/Izumi-v3
cd Izumi-v3 || { echo "Directory not found"; exit 1; }

# Step 8: Prompt user for configuration inputs
echo "Please enter your SESSION_ID:"
read SESSION_ID
echo "Please enter your MENU_URL (default: https://ik.imagekit.io/eypz/1722873079279_lHOJlrddC.png):"
read MENU_URL
MENU_URL=${MENU_URL:-https://ik.imagekit.io/eypz/1722873079279_lHOJlrddC.png}
echo "Please enter your CAPTION (default: Iᴢᴜᴍɪ):"
read CAPTION
CAPTION=${CAPTION:-Iᴢᴜᴍɪ}
echo "Please enter your OWNER_NAME (default: Eypz God):"
read OWNER_NAME
OWNER_NAME=${OWNER_NAME:-Eypz God}
echo "Please enter your BOT_NAME (default: 𝚰𝚭𝐔𝚳𝚰-𝚅3):"
read BOT_NAME
BOT_NAME=${BOT_NAME:-𝚰𝚭𝐔𝚳𝚰-𝚅3}
echo "Please enter your SUDO (default: null):"
read SUDO
SUDO=${SUDO:-null}
echo "Please enter your STICKER_PACKNAME (default: Izumi-v3,❤️):"
read STICKER_PACKNAME
STICKER_PACKNAME=${STICKER_PACKNAME:-Izumi-v3,❤️}
echo "Please enter your AUDIO_DATA (default: Eʏᴘᴢ;Iᴢᴜᴍɪ-ᴠ3;https://i.imgur.com/cO0TZJv.jpeg):"
read AUDIO_DATA
AUDIO_DATA=${AUDIO_DATA:-Eʏᴘᴢ;Iᴢᴜᴍɪ-ᴠ3;https://i.imgur.com/cO0TZJv.jpeg}
echo "Please enter your PROCESSNAME (default: Izumi-v3):"
read PROCESSNAME
PROCESSNAME=${PROCESSNAME:-Izumi-v3}
echo "Please enter your AUTHOR (default: Eypz God):"
read AUTHOR
AUTHOR=${AUTHOR:-Eypz God}
echo "Is this a Termux environment? (true/false, default: false):"
read TERMUX
TERMUX=${TERMUX:-false}

# Step 9: Update the config.js file
echo "Updating config.js with provided values..."
CONFIG_FILE="config.js" # Update this path if necessary

sed -i "s|SESSION_ID: '.*'|SESSION_ID: '$SESSION_ID'|g" $CONFIG_FILE
sed -i "s|MENU_URL: '.*'|MENU_URL: '$MENU_URL'|g" $CONFIG_FILE
sed -i "s|CAPTION: '.*'|CAPTION: '$CAPTION'|g" $CONFIG_FILE
sed -i "s|OWNER_NAME: '.*'|OWNER_NAME: '$OWNER_NAME'|g" $CONFIG_FILE
sed -i "s|BOT_NAME: '.*'|BOT_NAME: '$BOT_NAME'|g" $CONFIG_FILE
sed -i "s|SUDO: .*|SUDO: $SUDO|g" $CONFIG_FILE
sed -i "s|STICKER_PACKNAME: '.*'|STICKER_PACKNAME: '$STICKER_PACKNAME'|g" $CONFIG_FILE
sed -i "s|AUDIO_DATA: '.*'|AUDIO_DATA: '$AUDIO_DATA'|g" $CONFIG_FILE
sed -i "s|PROCESSNAME: '.*'|PROCESSNAME: '$PROCESSNAME'|g" $CONFIG_FILE
sed -i "s|AUTHOR: '.*'|AUTHOR: '$AUTHOR'|g" $CONFIG_FILE
sed -i "s|TERMUX: .*|TERMUX: $TERMUX|g" $CONFIG_FILE

# Step 10: Install dependencies
echo "Installing dependencies..."
npm install

# Step 11: Start the bot
echo "Starting the bot..."
npm start

echo "Bot installation and setup completed!"
