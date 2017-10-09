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
ln -s $PWD/tigrc ~/.tigrc
mkdir -p ~/.config/mc
ln -s $PWD/mc ~/.config/mc/ini
ln -s prelude ~/.emacs.d
ln -s $PWD/tmux.conf ~/.tmux.conf
ln -s $PWD/compton.conf ~/.compton.conf
ln -s $PWD/tigrc ~/.tigrc
ln -s $PWD/radare2rc ~/.radare2rc

if [ ! -d ~/.tmux/plugins/tpm ]; then
	mkdir -p ~/.tmux/plugins
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [ ! -f ~/.vim/autoload/pathogen ]; then
    mkdir -p ~/.vim/autoload ~/.vim/bundle && \
        curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
    git clone https://github.com/vim-airline/vim-airline.git ~/.vim/bundle/vim-airline
    git clone https://github.com/wincent/command-t.git ~/.vim/bundle/command-t
fi

if [ ! -d ~/src/ycmd ]; then
	mkdir -p ~/.tmux/plugins
    git clone https://github.com/Valloric/ycmd.git ~/src/ycmd
    cd ~/src/ycmd
    git submodule update --init --recursive
    ./build.py
    cd -
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
		sudo apt-get install -y zsh autojump silversearcher-ag screen vim git
	;;
esac
