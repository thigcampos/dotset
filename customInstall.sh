function get_os() {
    declare -A osInfo;
    osInfo[/etc/redhat-release]="dnf install"
    osInfo[/etc/arch-release]="pacman -S"
    osInfo[/etc/debian_version]="apt-get install"

    for f in ${!osInfo[@]}
    do
        if [[ -f $f ]];then
            echo ${osInfo[$f]}
        fi
    done
}

PKGMAN=$(get_os)

function confirm_install() {
    [[ "$(read -e -p "Install $1? [y/N]> "; echo $REPLY)" == [Yy]* ]] && $2 || echo "Skipping $1"
}

### INSTALL COMMANDS

function update_system() {
    sudo dnf update -y
    sudo dnf upgrade -y --refresh
    sudo dnf autoremove
    echo 'System Updated'
}

function install_rust() {
    curl --proto '=https' --tlsv1.2 -sSf hdnf install exattps://sh.rustup.rs | sh
    echo 'Rust Installed'
}

function install_rust_commands() {
    sudo $PKGMAN -y tealdeer procs ripgrep bat fd-find
    echo 'All Rust Commmands Installed'
}

function install_fish() {
    sudo $PKGMAN -y fish
    sudo $PKGMAN -y util-linux-user
    chsh -s /usr/bin/fish
    echo 'Fish Installed'    
}

function install_vscodium() {
    sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
    printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo
    sudo $PKGMAN -y codium 
    echo 'VSCodium Installed'
}

function install_neovim() {
    sudo $PKGMAN -y neovim python3-neovim
    cd ~/.config
    git clone --depth 1 https://github.com/wbthomason/packer.nvim\
    ~/.local/share/nvim/site/pack/packer/start/packer.nvim
    git clone https://gitlab.com/garzea/nvim.git
    sudo $PKGMAN -y gcc
    echo "Neovim Installed"
    echo "To apply all neovim configs, access ~/.config/nvim/lua/neovim/packer.lua and run :source and :PackerSync"
}

function install_node() {
    sudo $PKGMAN -y nodejs
    echo 'NodeJS Installed'
}

function install_yarn() {
    sudo npm install --global yarn
    echo 'Yarn Installed'
}

function install_xclip() {
    sudo $PKGMAN -y xclip
    echo 'Xclip Installed'
}

function install_neofetch() {
    sudo $PKGMAN -y neofetch
    echo 'Neofetch Installed'
}

function install_rpm_fusion() {
    sudo $PKGMAN https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
    echo 'RPM Fusion Installed'
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


for f in ${!applications_list[@]}
    do
        confirm_install ${applications_list[$f]} install_${applications_list[$f]}
    done


