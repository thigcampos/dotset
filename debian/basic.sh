# Rename and Move fonts folder
mv fonts .fonts &&
mv .fonts ~ &&

# Rename and Move zshrc file
mv zshrc .zshrc &&
mv .zshrc ~ &&

# Permissions
chmod +x zsh.sh &&
chmod +x plugins.sh
