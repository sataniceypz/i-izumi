#!/bin/bash
# Enhanced script to set up and deploy Izumi bot in Termux

# Function to display a welcome message
function display_welcome() {
    clear
    echo "========================================"
    echo "      Welcome to the Izumi Bot Setup    "
    echo "========================================"
    echo "This script will help you deploy the Izumi bot in Termux."
    echo "Please follow the prompts to complete the setup."
    echo ""
}

# Function to install packages
function install_packages() {
    echo "Updating packages..."
    apt update && apt upgrade -y

    echo "Installing required tools..."
    apt install wget openssl-tool proot -y
    hash -r
    wget https://raw.githubusercontent.com/EXALAB/AnLinux-Resources/master/Scripts/Installer/Ubuntu/ubuntu.sh
    bash ubuntu.sh

    echo "Starting Ubuntu..."
    ./start-ubuntu.sh

    echo "Installing packages in Ubuntu..."
    sudo apt update && sudo apt upgrade -y
    sudo apt install sudo ffmpeg imagemagick yarn git curl -y
    sudo apt install python3 python3-pip build-essential -y
    sudo apt install nano vim htop -y  # Additional text editors and monitoring tools
    sudo apt -y remove nodejs
    curl -fsSl https://deb.nodesource.com/setup_lts.x | sudo bash - && sudo apt -y install nodejs
}

# Function to clone the repository
function clone_repository() {
    echo "Cloning Izumi bot repository..."
    git clone https://github.com/sataniceypz/Izumi-v3.git
    cd Izumi-v3 || exit
}

# Function to install Node.js dependencies
function install_dependencies() {
    echo "Installing Node.js and dependencies..."
    npm install
}

# Function to create the config.env file
function create_config() {
    echo "Please enter your WhatsApp session ID:"
    read -r SESSION_ID

    echo "Please enter the command prefix (default: .):"
    read -r PREFIX
    PREFIX=${PREFIX:-.}  # Default to '.' if no input is provided

    echo "Please enter your SUDO number:"
    read -r SUDO

    echo "Creating config.env file..."
    {
        echo "TERMUX=true"
        echo "SESSION_ID=$SESSION_ID"
        echo "PREFIX=$PREFIX"
        echo "SUDO=$SUDO"
    } > config.env
}

# Function to start the bot
function start_bot() {
    echo "Starting the bot..."
    npm start
}

# Main script execution
display_welcome
install_packages
clone_repository
install_dependencies
create_config
start_bot
