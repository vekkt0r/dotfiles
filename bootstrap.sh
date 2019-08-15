#!/bin/sh

# We want to use our own rc, move existing one to avoid error
mv ~/.bashrc ~/.bashrc.org

mkdir -p ~/bin

ln -s $PWD/screenrc ~/.screenrc
ln -s $PWD/vimrc ~/.vimrc
ln -s $PWD/zshrc ~/.zshrc
ln -Ts $PWD/irssi ~/.irssi
ln -s $PWD/bashrc ~/.bashrc
ln -s $PWD/inputrc ~/.inputrc
ln -Ts $PWD/ncmpcpp ~/.ncmpcpp
ln -s $PWD/gdbinit.simple ~/.gdbinit
ln -s $PWD/vimperatorrc ~/.vimperatorrc
mkdir -p ~/.ssh/
ln -s $PWD/ssh_config ~/.ssh/config
ln -s $PWD/gitconfig ~/.gitconfig
ln -s $PWD/tigrc ~/.tigrc
mkdir -p ~/.config/mc
ln -s $PWD/mc ~/.config/mc/ini
ln -s $PWD/tmux.conf ~/.tmux.conf
ln -s $PWD/compton.conf ~/.compton.conf
ln -s $PWD/emacs.d ~/.emacs.d
ln -s $PWD/radare2rc ~/.radare2rc
mkdir -p ~/.config/alacritty
ln -s $PWD/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -s $PWD/nvim ~/.config/nvim
ln -s $PWD/quiltrc ~/.quiltrc
ln -s $PWD/bin/runonce.sh ~/bin/runonce.sh
ln -s $PWD/kitty.conf ~/.config/kitty/kitty.conf

if [ ! -d ~/.tmux/plugins/tpm ]; then
	mkdir -p ~/.tmux/plugins
	git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

# Essentials
#sudo apt install -y curl

if [ ! -f ~/.vim/autoload/pathogen ]; then
    mkdir -p ~/.vim/autoload ~/.vim/bundle && \
        curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
    git clone https://github.com/vim-airline/vim-airline.git ~/.vim/bundle/vim-airline
    git clone https://github.com/wincent/command-t.git ~/.vim/bundle/command-t
    git clone https://github.com/scrooloose/nerdcommenter.git ~/.vim/bundle/nerdcommenter
    git clone https://github.com/vim-scripts/Conque-GDB.git ~/.vim/bundle/Conque-GDB
    git clone https://github.com/rhysd/vim-clang-format.git ~/.vim/bundle/vim-clang-format
    git clone https://github.com/SirVer/ultisnips.git ~/.vim/bundle/ultisnips 
    git clone https://github.com/mileszs/ack.vim.git ~/.vim/bundle/ack.vim
    ln -s ~/src/dotfiles/snippets/ultisnips ~/.vim/UltiSnips
fi

if [ ! -d ~/src/ycmd ]; then
	mkdir -p ~/.tmux/plugins
    git clone https://github.com/Valloric/ycmd.git ~/src/ycmd
    cd ~/src/ycmd
    git submodule update --init --recursive
    ./build.py
    cd -
fi

if [ ! -d ~/.local/share/nvim/site/autoload/plug.vim ]; then
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

unamestr=$(uname)
case $unamestr in
	"Darwin")
    	mkdir -p ~/Library/KeyBindings/
    	ln -s $PWD/DefaultKeyBinding.dict ~/Library/KeyBindings/DefaultKeyBinding.dict	
        ln -s $PWD/USMD.bundle ±/Library/Keyboard\ Layouts/USMD.bundle
	;;
	"Linux")
		ln -s $PWD/awesome ~/.config/awesome
		ln -s $PWD/Xresources ~/.Xresources
		gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'
		if [ -f /etc/lsb-release ]; then
			# Probably Ubuntu
			sudo apt-get install -y zsh autojump silversearcher-ag screen tmux \
		    vim git jq tig
		else
            # Fallback to Fedora
            # TODO: Check actual dist
			sudo dnf install -y zsh autojump the_silver_searcher screen tmux vim git jq tig xclip slock

            # only for numix-solarized
            sudo dnf install -y ruby-devel redhat-rpm-config glib2-devel gdk-pixbuf2-devel inkscape gtk-murrine-engine google-roboto-mono-fonts google-roboto-fonts
            sudo gem install sass
            cd ~/src && git clone https://github.com/Ferdi265/numix-solarized-gtk-theme.git && cd numix-solarized-grk-theme && sudo make THEME=SolarizedDarkBlue install
		fi
	;;
esac
