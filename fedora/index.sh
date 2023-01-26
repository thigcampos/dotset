if [ -d ~/Repositories/ ] 
then 
	cd ~/Repositories/
else
	mkdir ~/Repositories/ && cd ~/Repositories/ 
fi 

# Lynx: Terminal Browser
sudo dnf install -y lynx &&

# Mull: Terminal Email Client
sudo dnf install -y mull &&

# Neovim: Updated version of Vim (Terminal IDE)
sudo dnf install -y neovim python3-neovim &&

# Fish: Improved shell
sudo dnf install -y fish &&
sudo dnf install -y util-linux-user &&
chsh -s /usr/bin/fish &&

# Neofetch
sudo dnf install -y neofetch &&



# Move nvim folder to .config 
mv -f nvim ~/.config &&
