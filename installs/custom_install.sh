#!/bin/bash

# Custom Install

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

confirm_install() {
    [[ "$(read -e -p "\e[0;1mInstall $1? [y/N]> "; echo $REPLY)" == [Yy]* ]] && $2 || echo "Skipping $1"
}

### START

echo ""
echo -e "\e[0;32mCustom Install - Preferences\e[0m"
echo "To install some applications is necessary to use Flatpak."
FLATPAK_PREFERENCE=$(get_flatpak_preference)


### INSTALL COMMANDS

PKG_INSTALL=$(get_pkgman_install)
PKG_UPDATE=$(get_pkgman_update)
PKG_UPGRADE=$(get_pkgman_upgrade)


update_system() {
    echo $PKG_UPDATE
    echo $PKG_UPGRADE
    sudo $PKG_UPDATE
    sudo $PKG_UPGRADE
    echo -e "\e[1;34mSystem Updated\e[0m"
}

install_rust() {
    curl --proto '=https' --tlsv1.2 -sSf hdnf install exattps://sh.rustup.rs | sh
    echo -e "\e[1;34mRust Installed\e[0m"
}

install_rust_commands() {
    sudo $PKG_INSTALL -y tealdeer procs ripgrep bat fd-find
    echo -e "\e[1;34mAll Rust Commmands Installed\e[0m"
}

install_fish() {
    sudo $PKG_INSTALL -y fish
    sudo $PKG_INSTALL -y util-linux-user
    chsh -s /usr/bin/fish
    echo -e "\e[1;34mFish Installed\e[0m"
}

install_vscodium() {
    sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
    printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo
    sudo $PKG_INSTALL -y codium 
    echo -e "\e[1;34mVSCodium Installed\e[0m"
}

install_neovim() {
    sudo $PKG_INSTALL -y neovim python3-neovim
    cd ~/.config
    git clone --depth 1 https://github.com/wbthomason/packer.nvim\
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    git clone https://gitlab.com/garzea/nvim.git
    sudo $PKG_INSTALL -y gcc
    echo -e "\e[1;34mNeovim Installed\e[0m"
    echo "To apply all neovim configs, access ~/.config/nvim/lua/neovim/packer.lua and run :source and :PackerSync"
}

install_node() {
    sudo $PKG_INSTALL -y nodejs
    echo -e "\e[1;34mNodeJS Installed\e[0m"
}

install_yarn() {
    sudo npm install --global yarn
    echo -e "\e[1;34mYarn Installed\e[0m"
}

install_xclip() {
    sudo $PKG_INSTALL -y xclip
    echo -e "\e[1;34mXclip Installed\e[0m"
}

install_neofetch() {
    sudo $PKG_INSTALL -y neofetch
    echo -e "\e[1;34mNeofetch Installed\e[0m"
}

install_rpm_fusion() {
    sudo $PKG_INSTALL https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    echo -e "\e[1;34mRPM Fusion Installed\e[0m"
}

install_flatpak() {
    sudo $PKG_INSTALL flatpak
    echo -e "\e[1;34mFlatpak Installed\e[0m"
}

install_firefox() {
    flatpak install -y flathub org.mozilla.firefox
    echo -e "\e[1;34mFirefox Installed\e[0m"
}

install_signal() {
    flatpak install -y flathub org.signal.Signal
    echo -e "\e[1;34mSignal Installed\e[0m"
}

## Prepare Install
declare -a applications_list=(\
    "rust"\
    "rust_commands"\
    "fish"\
    "vscodium"\
    "neovim"\
    "node"\
    "yarn"\
    "xclip"\
    "neofetch"\
)

if [[ -f "/etc/redhat-release" ]]
then
    applications_list+=("rpm_fusion")
fi

if [ $FLATPAK_PREFERENCE = "Accepted" ] 
then
    if ! check_command flatpak; then 
        applications_list+=("flatpak")
    fi
    applications_list+=("firefox")
    applications_list+=("signal")  
fi

## Update System
echo ""
update_system

## Run Install Functions
for f in ${!applications_list[@]}
do
    echo ""
    confirm_install ${applications_list[$f]} install_${applications_list[$f]}
done

## Finish
### Update System
echo ""
update_system
### Run Finish Script
../run_end.sh