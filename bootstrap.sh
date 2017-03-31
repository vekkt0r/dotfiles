#!/bin/sh

# We want to use our own rc, move existing one to avoid error
mv ~/.bashrc ~/.bashrc.org

ln -s $PWD/screenrc ~/.screenrc
ln -s $PWD/vimrc ~/.vimrc
ln -s $PWD/zshrc ~/.zshrc
ln -s $PWD/irssi ~/.irssi
ln -s $PWD/bashrc ~/.bashrc
ln -s $PWD/inputrc ~/.inputrc
ln -s $PWD/ncmpcpp ~/.ncmpcpp
ln -s $PWD/gdbinit.simple ~/.gdbinit
ln -s $PWD/vimperatorrc ~/.vimperatorrc
ln -s $PWD/ssh_config ~/.ssh/config
ln -s $PWD/gitconfig ~/.gitconfig
mkdir -p ~/.config/mc
ln -s $PWD/mc ~/.config/mc/ini
ln -s prelude ~/.emacs.d
ln -s $PWD/tmux.conf ~/.tmux.conf
ln -s $PWD/compton.conf ~/.compton.conf
ln -s $PWD/tigrc ~/.tigrc

if [ ! -d ~/.tmux/plugins/tpm ]; then
	mkdir -p ~/.tmux/plugins
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

unamestr=$(uname)
case $unamestr in
	"Darwin")
    	mkdir -p ~/Library/KeyBindings/
    	ln -s $PWD/DefaultKeyBinding.dict ~/Library/KeyBindings/DefaultKeyBinding.dict	
	;;
	"Linux")
		ln -s $PWD/awesome ~/.config/awesome
		ln -s $PWD/Xresources ~/.Xresources
		sudo apt-get install -y zsh autojump ack-grep screen vim git
	;;
esac
