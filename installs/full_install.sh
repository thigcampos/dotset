#!/bin/bash

# Full Install

## Utils 
check_command() {
    command -v "$1" > /dev/null 2>&1
}

get_package_manager() {
    declare -A osInfo;
    osInfo[/etc/redhat-release]="dnf"
    osInfo[/etc/arch-release]="pacman"
    osInfo[/etc/debian_version]="apt-get"

    for f in ${!osInfo[@]}
    do
        if [[ -f $f ]];then
            echo ${osInfo[$f]}
        fi
    done
}

PKGMAN=$(get_package_manager)

get_pkgman_install() {
    case $PKGMAN in
        "dnf")
            command="$PKGMAN install"
            ;;
        "pacman")
            command="$PKGMAN -S"
            ;;
        "apt-get")
            command="$PKGMAN install"
            ;;
        *)
            command="$PKGMAN install"
            ;;
    esac

    echo "$command"
}

get_pkgman_update() {
    case $PKGMAN in
        "dnf")
            command="$PKGMAN update"
            ;;
        "pacman")
            command="$PKGMAN -Syu"
            ;;
        "apt-get")
            command="$PKGMAN update"
            ;;
        *)
            command="$PKGMAN update"
            ;;
    esac

    echo "$command"
}

get_pkgman_upgrade() {
    case $PKGMAN in
        "dnf")
            command="$PKGMAN upgrade --refresh"
            ;;
        "pacman")
            command="$PKGMAN -Syu"
            ;;
        "apt-get")
            command="$PKGMAN upgrade"
            ;;
        *)
            command="$PKGMAN upgrade"
            ;;
    esac

    echo "$command"
}


get_flatpak_preference() {
    read -p "Do you agree to use it [y/N]: " choice
    
    case $choice in
        [Yy]|[Ys][Es][Ss])
            echo Accepted
            ;;
        [Nn]|[Nn][Oo])
            echo Declined
            ;;
        *)
            get_flatpak_preference
            ;;
    esac
}

## Setup
### Greedings and FlatPak Preferences
echo ""
echo -e "\e[0;32mFull Install - Preferences\e[0m"
echo "To install some applications is necessary to use Flatpak."
FLATPAK_PREFERENCE=$(get_flatpak_preference)

### Package Manager Commands
PKG_INSTALL=$(get_pkgman_install)
PKG_UPDATE=$(get_pkgman_update)
PKG_UPGRADE=$(get_pkgman_upgrade)

## Update System
### Utils
update_system() {
    echo ""
    echo $PKG_UPDATE
    echo $PKG_UPGRADE
    sudo $PKG_UPDATE
    sudo $PKG_UPGRADE
    echo 'System Updated'
}

### Run commands
update_system

## Install 
### If in RedHat System and Accepted FLATPAK --- Remove Firefox
if [ $FLATPAK_PREFERENCE = "Accepted" ] 
then
    if [[ -f "/etc/redhat-release" ]]; then
        ### Firefox
        sudo dnf remove -y firefox
        echo 'Firefox Removed'
    fi
fi

### Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
echo 'Rust Installed'

### Java
sudo $PKG_INSTALL -y java-latest-openjdk-devel.x86_64
echo 'Java Installed'

### Rust Commands
sudo $PKG_INSTALL -y tealdeer procs ripgrep bat fd-find
echo 'All Rust Commmands Installed'

### Fish
sudo $PKG_INSTALL -y fish
sudo $PKG_INSTALL -y util-linux-user
chsh -s /usr/bin/fish
echo 'Fish Installed'

### VSCodium
sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo
sudo $PKG_INSTALL -y codium 
echo 'VSCodium Installed'

### Node
sudo $PKG_INSTALL -y nodejs
echo 'NodeJS Installed'

### Yarn
sudo npm install --global yarn
echo 'Yarn Installed'

### Xclip
sudo $PKG_INSTALL -y xclip
echo 'Xclip Installed'

### Neovim
sudo $PKG_INSTALL -y neovim python3-neovim
echo 'Neovim Installed'

### Neofetch
sudo $PKG_INSTALL -y neofetch
echo 'Neofetch Installed'

### Check if is RedHat System
if [[ -f "/etc/redhat-release" ]]
then
    ### RPM Fusion
    sudo $PKG_INSTALL https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    echo 'RPM Fusion Installed'
fi

if [ $FLATPAK_PREFERENCE = "Accepted" ] 
then
    if ! check_command flatpak; then 
        ### Flatpak
        sudo $PKG_INSTALL flatpak
        echo 'Flatpak Installed'
    fi
    if [[ -f "/etc/redhat-release" ]]; then
        ### Firefox
        flatpak install -y flathub org.mozilla.firefox
        echo 'Firefox Installed'\
    fi
    ### Signal
    flatpak install -y flathub org.signal.Signal
    echo 'Signal Installed'
fi

## Finish
### Update System
update_system
### Run Finish Script
../run_end.sh