# Microsoft Teams
wget https://packages.microsoft.com/repos/ms-teams/pool/main/t/teams/teams_1.5.00.10453_amd64.deb &&
sudo dpkg -i teams_1.5.00.10453_amd64.deb &&

# Signal
wget -O- https://updates.signal.org/desktop/apt/keys.asc | sudo apt-key add - &&
echo "deb [arch=amd64] https://updates.signal.org/desktop/apt xenial main" | sudo tee -a /etc/apt/sources.list.d/signal-xenial.list &&
sudo apt update && sudo apt install signal-desktop 
