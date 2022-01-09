cp -ar .config ~
cp -ar .xmonad ~
cp -ar .oh-my-zsh ~
cp -ar .zshrc ~

chmod +x .config/scripts/volumeControl.sh

sudo cp .config/scripts/volumeControl.sh /bin/volumecontrol
