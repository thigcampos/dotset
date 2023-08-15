# Fish
sudo dnf install -y fish &&
sudo dnf install -y util-linux-user &&
chsh -s /usr/bin/fish &&
echo 'Fish Installed' &&

# VSCodium
sudo rpmkeys --import https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg &&
printf "[gitlab.com_paulcarroty_vscodium_repo]\nname=download.vscodium.com\nbaseurl=https://download.vscodium.com/rpms/\nenabled=1\ngpgcheck=1\nrepo_gpgcheck=1\ngpgkey=https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/-/raw/master/pub.gpg\nmetadata_expire=1h" | sudo tee -a /etc/yum.repos.d/vscodium.repo &&
sudo dnf install -y codium &&
echo 'VSCodium Installed' &&

# Chrome
wget https://dl.google.com/linux/direct/google-chrome-stable_current_x86_64.rpm &&
sudo dnf localinstall ./google-chrome-stable_current_x86_64.rpm &&
sudo dnf install -y google-chrome-stable &&
echo 'Chrome Installed' &&

# Node
sudo dnf install -y nodejs &&
echo 'NodeJS Installed' &&

# Yarn
sudo npm install --global yarn &&
echo 'Yarn Installed' &&

# Xclip
sudo dnf install -y xclip &&
echo 'Xclip Installed' &&

# Docker
sudo dnf -y install dnf-plugins-core
sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
echo 'Docker Installed' &&
# Issues? Check: https://docs.docker.com/desktop/install/fedora/

# Neovim
sudo dnf install -y neovim python3-neovim &&
echo 'Neovim Installed' &&

# Neofetch
sudo dnf install -y neofetch &&
echo 'Neofetch Installed' &&

echo 'Done'
