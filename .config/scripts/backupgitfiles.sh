if [ ! -d "${HOME}/Documents/dotfiles/.config" ]; then
    mkdir ${HOME}/Documents/dotfiles/.config
fi
if [ ! -d "${HOME}/Documents/dotfiles/.oh-my-zsh" ]; then
    mkdir ${HOME}/Documents/dotfiles/.oh-my-zsh
fi
if [ ! -d "${HOME}/Documents/dotfiles/.xmonad" ]; then
    mkdir ${HOME}/Documents/dotfiles/.xmonad
fi

cp -r ${HOME}/.config/* ${HOME}/Documents/dotfiles/.config
cp -r ${HOME}/.oh-my-zsh/* ${HOME}/Documents/dotfiles/.oh-my-zsh
cp -r ${HOME}/.xmonad/* ${HOME}/Documents/dotfiles/.xmonad
cp -r ${HOME}/.zshrc ${HOME}/Documents/dotfiles


cd ~/Documents/dotfiles
if [[ `git status --porcelain` ]]; then
    # Changes
    git add  .
    git commit -m "UpdatedFiles"
    git push
else
   echo "Everything is up-to-date"
fi

cd ~