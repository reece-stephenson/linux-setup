# Install the newest version of git
# https://askubuntu.com/questions/568591/how-do-i-install-the-latest-version-of-git-with-apt
echo "Setting up the latest Git"
sudo apt-add-repository ppa:git-core/ppa
sudo apt update -y && sudo apt upgrade -y
sudo apt install git

# Update all packages
sudo apt dist-upgrade -y
sudo apt autoremove -y

# Using the Git Credential Manager for Git CLI on windows
# https://learn.microsoft.com/en-us/windows/wsl/tutorials/wsl-git#git-credential-manager-setup
git config --global credential.helper "/mnt/c/Program\ Files/Git/mingw64/bin/git-credential-manager.exe"

echo "Git setup complete"
echo "Setting up Oh My Zsh"

# Install Oh My Zsh
sudo apt install zsh -y
# echo $SHELL
# chsh -s /usr/bin/zsh
# TODO: Add configuration for restarting terminal

sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Use the template .zshrc file
cp templates/.zshrc ~/.zshrc

# TODO: Add configuration for restarting terminal
echo "Oh My Zsh setup complete"
echo "Setting up Spaceship"

git clone https://github.com/spaceship-prompt/spaceship-prompt.git "$ZSH_CUSTOM/themes/spaceship-prompt" --depth=1
ln -s "$ZSH_CUSTOM/themes/spaceship-prompt/spaceship.zsh-theme" "$ZSH_CUSTOM/themes/spaceship.zsh-theme"

# Use the template .spaceshiprc.zsh file
cp templates/.spaceshiprc.zsh ~/.spaceshiprc.zsh

echo "Spaceship setup complete"
