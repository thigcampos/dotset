# Plugins

# ZSH Auto-suggestions
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions &&

# Install MesloLGS
open "https://github.com/romkatv/powerlevel10k#meslo-nerd-font-patched-for-powerlevel10k" &&

# Powerlevel 10k
git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k && exec zsh && p10k configure
