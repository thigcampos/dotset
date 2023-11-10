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

# Initial
sudo dnf update -y
sudo dnf upgrade -y --refresh
sudo dnf remove -y firefox
# Removing default Firefox to then add suport for DRM content

# Rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
echo 'Rust Installed'

# Java
sudo $PKGMAN -y java-latest-openjdk-devel.x86_64
echo 'Java Installed'

# Rust Commands
sudo $PKGMAN -y tealdeer procs ripgrep bat fd-find
echo 'All Rust Commmands Installed'

# Fish
sudo $PKGMAN -y fish
sudo $PKGMAN -y util-linux-user
chsh -s /usr/bin/fish
echo 'Fish Installed'

# VSCodium
sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo
sudo $PKGMAN -y codium 
echo 'VSCodium Installed'

# Node
sudo $PKGMAN -y nodejs
echo 'NodeJS Installed'

# Yarn
sudo npm install --global yarn
echo 'Yarn Installed'

# Xclip
sudo $PKGMAN -y xclip
echo 'Xclip Installed'

# Docker
sudo $PKGMAN -y dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo $PKGMAN -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo 'Docker Installed'
# Issues? Check: https://docs.docker.com/desktop/install/fedora/

# Neovim
sudo $PKGMAN -y neovim python3-neovim
echo 'Neovim Installed'

# Neofetch
sudo $PKGMAN -y neofetch
echo 'Neofetch Installed'

# RPM Fusion
sudo $PKGMAN https://mirrors.rpmfusion.org/free/fedora/rpmfusion-free-release-$(rpm -E %fedora).noarch.rpm https://mirrors.rpmfusion.org/nonfree/fedora/rpmfusion-nonfree-release-$(rpm -E %fedora).noarch.rpm
echo 'RPM Fusion Installed'

# Firefox
flatpak install -y flathub org.mozilla.firefox
echo 'Firefox Installed'

# Signal
flatpak install -y flathub org.signal.Signal
echo 'Signal Installed'

# Feeds
flatpak install -y flathub org.gabmus.gfeeds
echo 'Feeds Installed'

# Heroic Games
flatpak install -y flathub com.heroicgameslauncher.hgl
echo 'Heroic Games Installed'

sudo dnf update -y && sudo dnf upgrade -y
echo 'Done'
