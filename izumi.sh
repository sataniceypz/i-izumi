#!/bin/bash
# Script to set up and deploy Izumi bot in Termux

# Step 1: Update and Upgrade Packages
echo "Updating packages..."
apt update && apt upgrade -y

# Step 2: Install Required Tools
echo "Installing required tools..."
apt install wget openssl-tool proot -y
hash -r
wget https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Scripts/Installer/Ubuntu/ubuntu.sh
bash ubuntu.sh

# Step 3: Start Ubuntu
echo "Starting Ubuntu..."
./start-ubuntu.sh

# Step 4: Install Packages in Ubuntu
echo "Installing packages in Ubuntu..."
sudo apt update && sudo apt upgrade -y
sudo apt install sudo -y
sudo apt install ffmpeg -y
sudo apt install imagemagick -y
sudo apt install yarn -y
sudo apt install git -y
sudo apt install curl -y
sudo apt -y remove nodejs
curl -fsSl https://deb.nodesource.com/setup_lts.x | sudo bash - && sudo apt -y install nodejs

# Step 5: Clone the GitHub Repo
echo "Cloning Izumi bot repository..."
git clone https://github.com/sataniceypz/Izumi-v3.git
cd Izumi-v3

# Step 6: Install Node.js Dependencies
echo "Installing Node.js and dependencies..."
npm install

# Step 7: Ask for Configuration Inputs
echo "Please enter your WhatsApp session ID:"
read SESSION_ID

echo "Please enter the command prefix (default: .):"
read PREFIX
PREFIX=${PREFIX:-.}  # Default to '.' if no input is provided

echo "Please enter your SUDO number:"
read SUDO

# Step 8: Create config.env File
echo "Creating config.env file..."
{
  echo "TERMUX=true"
  echo "SESSION_ID=$SESSION_ID"
  echo "PREFIX=$PREFIX"
  echo "SUDO=$SUDO"
} > config.env

# Step 9: Start the Bot
echo "Starting the bot..."
npm start
