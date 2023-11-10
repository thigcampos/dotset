#!/bin/sh

header_title() {
    echo -e "\e[1;32m        _            _          _          _            _          _       \e[0m"
    echo -e "\e[1;32m       /\ \         /\ \       /\ \       / /\         /\ \       /\ \     \e[0m"
    echo -e "\e[1;32m      /  \ \____   /  \ \      \_\ \     / /  \       /  \ \      \_\ \    \e[0m"
    echo -e "\e[1;32m     / /\ \_____\ / /\ \ \     /\__ \   / / /\ \__   / /\ \ \     /\__ \   \e[0m"
    echo -e "\e[1;32m    / / /\/___  // / /\ \ \   / /_ \ \ / / /\ \___\ / / /\ \_\   / /_ \ \  \e[0m"
    echo -e "\e[1;32m   / / /   / / // / /  \ \_\ / / /\ \ \\ \ \ \/___// /_/_ \/_/  / / /\ \ \ \e[0m"
    echo -e "\e[1;32m  / / /   / / // / /   / / // / /  \/_/ \ \ \     / /____/\    / / /  \/_/ \e[0m"
    echo -e "\e[1;32m / / /   / / // / /   / / // / /    _    \ \ \   / /\____\/   / / /        \e[0m"
    echo -e "\e[1;32m \ \ \__/ / // / /___/ / // / /    /_/\__/ / /  / / /______  / / /         \e[0m"
    echo -e "\e[1;32m  \ \___\/ // / /____\/ //_/ /     \ \/___/ /  / / /_______\/_/ /          \e[0m"
    echo -e "\e[1;32m   \/_____/ \/_________/ \_\/       \_____\/   \/__________/\_\/           \e[0m"                                                                                   
    echo ""
    echo ""
}

# Function to display the title
text_title() {
    echo -e "\e[1;32mDotSet: Streamlined Dotfiles Installation\e[0m"
}

# Function to show the message
text_message() {
    echo "Effortlessly install and configure essential apps and personalized settings."
    echo "Your terminal, your rules. Let DotSet handle the setup hassle for you!"
    echo ""
}

full_install() {
    echo "Performing full installation..."
    ./fullInstall.sh
}

custom_install() {
    echo "Performing custom installation..."
    ./customInstall.sh
}

choose_install() {
    echo "Choose an installation option:"
    echo "1. Custom Install [Recommended]"
    echo "2. Full Install"

    read -p "Enter your choice (1 or 2): " choice

    case $choice in
        1)
            custom_install
            ;;
        2)
            full_install
            ;;
        *)
            echo "Choose a valid option."
            echo ""
            choose_install
            ;;
    esac
}

# Execution
header_title
text_title
text_message
choose_install
