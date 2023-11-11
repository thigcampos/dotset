#!/bin/bash

### UTILS

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
    [[ "$(read -e -p "Install $1? [y/N]> "; echo $REPLY)" == [Yy]* ]] && $2 || echo "Skipping $1"
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
    echo 'System Updated'
}

install_rust() {
    curl --proto '=https' --tlsv1.2 -sSf hdnf install exattps://sh.rustup.rs | sh
    echo 'Rust Installed'
}

install_rust_commands() {
    sudo $PKG_INSTALL -y tealdeer procs ripgrep bat fd-find
    echo 'All Rust Commmands Installed'
}

install_fish() {
    sudo $PKG_INSTALL -y fish
    sudo $PKG_INSTALL -y util-linux-user
    chsh -s /usr/bin/fish
    echo 'Fish Installed'    
}

install_vscodium() {
    sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
    printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo
    sudo $PKG_INSTALL -y codium 
    echo 'VSCodium Installed'
}

install_neovim() {
    sudo $PKG_INSTALL -y neovim python3-neovim
    cd ~/.config
    git clone --depth 1 https://github.com/wbthomason/packer.nvim\
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    git clone https://gitlab.com/garzea/nvim.git
    sudo $PKG_INSTALL -y gcc
    echo "Neovim Installed"
    echo "To apply all neovim configs, access ~/.config/nvim/lua/neovim/packer.lua and run :source and :PackerSync"
}

install_node() {
    sudo $PKG_INSTALL -y nodejs
    echo 'NodeJS Installed'
}

install_yarn() {
    sudo npm install --global yarn
    echo 'Yarn Installed'
}

install_xclip() {
    sudo $PKG_INSTALL -y xclip
    echo 'Xclip Installed'
}

install_neofetch() {
    sudo $PKG_INSTALL -y neofetch
    echo 'Neofetch Installed'
}

install_rpm_fusion() {
    sudo $PKG_INSTALL https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    echo 'RPM Fusion Installed'
}

install_flatpak() {
    sudo $PKG_INSTALL flatpak
    echo 'Flatpak Installed'
}

install_firefox() {
    flatpak install -y flathub org.mozilla.firefox
    echo 'Firefox Installed'
}

install_signal() {
    flatpak install -y flathub org.signal.Signal
    echo 'Signal Installed'
}

### RUN INSTALL
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

echo ""
update_system
for f in ${!applications_list[@]}
do
    echo ""
    confirm_install ${applications_list[$f]} install_${applications_list[$f]}
done
echo ""
update_system
