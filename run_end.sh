#/bin/bash!

# Ending

## Utils
finish_title() {
    echo ""
    echo -e "\e[0;32m        _            _            _             _      \e[0m"
    echo -e "\e[0;32m       /\ \         /\ \         /\ \     _    /\ \    \e[0m"
    echo -e "\e[0;32m      /  \ \____   /  \ \       /  \ \   /\_\ /  \ \   \e[0m"
    echo -e "\e[0;32m     / /\ \_____\ / /\ \ \     / /\ \ \_/ / // /\ \ \  \e[0m"
    echo -e "\e[0;32m    / / /\/___  // / /\ \ \   / / /\ \___/ // / /\ \_\ \e[0m"
    echo -e "\e[0;32m   / / /   / / // / /  \ \_\ / / /  \/____// /_/_ \/_/ \e[0m"
    echo -e "\e[0;32m  / / /   / / // / /   / / // / /    / / // /____/\    \e[0m"
    echo -e "\e[0;32m / / /   / / // / /   / / // / /    / / // /\____\/    \e[0m"
    echo -e "\e[0;32m \ \ \__/ / // / /___/ / // / /    / / // / /______    \e[0m"
    echo -e "\e[0;32m  \ \___\/ // / /____\/ // / /    / / // / /_______\   \e[0m"
    echo -e "\e[0;32m   \/_____/ \/_________/ \/_/     \/_/ \/__________/   \e[0m"
    echo ""
    echo ""
}

display_all_set() {
    echo "You are all set!"
    echo "For any additional setup or detailed information refer to the README file in the DotSet repository."
    echo ""
}

display_thank_you() {
     echo -e "\e[0;32mThank you for using DotSet! Your support is highly appreciated.\e[0m"
}

## Execution

### Thanks
finish_title
display_all_set
display_thank_you