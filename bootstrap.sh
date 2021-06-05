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
ln -s $PWD/vimperatorrc ~/.vimperatorrc
mkdir -p ~/.ssh/
ln -s $PWD/ssh_config ~/.ssh/config
ln -s $PWD/ssh_rc ~/.ssh/rc
ln -s $PWD/gitconfig ~/.gitconfig
ln -s $PWD/tigrc ~/.tigrc
mkdir -p ~/.config/mc
ln -sn $PWD/mc ~/.config/mc
ln -s $PWD/tmux.conf ~/.tmux.conf
ln -s $PWD/compton.conf ~/.compton.conf
ln -sn $PWD/emacs.d ~/.emacs.d
ln -s $PWD/radare2rc ~/.radare2rc
mkdir -p ~/.config/alacritty
ln -s $PWD/alacritty.yml ~/.config/alacritty/alacritty.yml
ln -sn $PWD/nvim ~/.config/nvim
ln -s $PWD/quiltrc ~/.quiltrc
ln -s $PWD/bin/runonce.sh ~/bin/runonce.sh
mkdir -p ~/.config/kitty
ln -s $PWD/kitty.conf ~/.config/kitty/kitty.conf
mkdir -p ~/.mutt
ln -s $PWD/muttrc ~/.mutt/muttrc
ln -s $PWD/mutt_mailcap ~/.mutt/mailcap
ln -s $PWD/gdbinit.dashboard ~/.gdbinit

if [ ! -d oh-my-zsh ]; then
  git clone --depth 1 https://github.com/robbyrussell/oh-my-zsh.git
fi

if [ ! -d ~/.tmux/plugins/tpm ]; then
	mkdir -p ~/.tmux/plugins
	git clone --depth 1 https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
fi

if [ ! -d ~/.fzf ]; then
  git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
  ~/.fzf/install --no-update-rc --no-completion --no-key-bindings --no-update-rc
fi

# Essentials
#sudo apt install -y curl

if [ ! -f ~/.vim/autoload/pathogen ]; then
    mkdir -p ~/.vim/autoload ~/.vim/bundle && \
        curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
    git clone --depth 1 https://github.com/vim-airline/vim-airline.git ~/.vim/bundle/vim-airline
    #git clone https://github.com/wincent/command-t.git ~/.vim/bundle/command-t
    git clone --depth 1 https://github.com/scrooloose/nerdcommenter.git ~/.vim/bundle/nerdcommenter
    #git clone --depth 1 https://github.com/rhysd/vim-clang-format.git ~/.vim/bundle/vim-clang-format
    git clone --depth 1 https://github.com/SirVer/ultisnips.git ~/.vim/bundle/ultisnips
    #git clone --depth 1 https://github.com/mileszs/ack.vim.git ~/.vim/bundle/ack.vim
    ln -sn ~/src/dotfiles/snippets/ultisnips ~/.vim/UltiSnips
fi

if [ ! -d ~/.local/share/nvim/site/autoload/plug.vim ]; then
    curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
        https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fi

unamestr=$(uname)
case $unamestr in
	"Darwin")
    brew=$(which brew)
    if [ $? -ne 0 ]; then
      /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
    fi
    brew cask install alfred
    brew cask install docker
    brew cask install firefox
    brew cask install homebrew/cask-fonts/font-hack
    brew cask install spotify
    brew install ag
    brew install autojump
    brew install binwalk
    brew install bluetoothconnector
    brew install cmake
    #brew install --HEAD universal-ctags/universal-ctags/universal-ctags
    brew install fzf
    brew install python
    brew install tig
    brew install tmux
    brew install vim
    brew install nvim
    brew install unrtf
    mkdir -p ~/Library/KeyBindings/
    ln -s $PWD/DefaultKeyBinding.dict ~/Library/KeyBindings/DefaultKeyBinding.dict
    ln -s $PWD/USMD.bundle ~/Library/Keyboard\ Layouts/USMD.bundle
    ln -s $PWD/hammerspoon ~/.hammerspoon
	;;
	"Linux")
		ln -sn $PWD/awesome ~/.config/awesome
		ln -s $PWD/Xresources ~/.Xresources
    gs=$(which gsettings)
    if [ $? -eq 0 ]; then
      gsettings set org.gnome.nautilus.preferences default-folder-viewer 'list-view'
    fi
    if [ `id -u` -eq 0 ]; then
      sudo () { $@; }
    fi
		if [ -f /etc/lsb-release ]; then
			# Probably Ubuntu
			sudo apt-get install -y --no-install-recommends zsh autojump silversearcher-ag screen tmux \
		    vim git jq tig python-pip python3-pip
      pip install setuptools wheel
      pip install neovim
      pip3 install setuptools wheel 
      pip3 install neovim python-language-server pycodestyle pyflakes black rope

      # Apt version usually very old
      nv=$(which nvim)
      if [ $? -ne 0 ]; then
        curl -sL https://github.com/neovim/neovim/releases/download/stable/nvim-linux64.tar.gz | tar xz -C ~/bin
        ln -s ~/bin/nvim-linux64/bin/nvim ~/bin/nvim
        # Install plugins
        #~/bin/nvim +PlugInstall +qall > /dev/null
      fi
		else
            # Fallback to Fedora
            # TODO: Check actual dist
			sudo dnf install -y zsh autojump the_silver_searcher screen tmux vim git jq tig xclip slock

            # only for numix-solarized
            sudo dnf install -y ruby-devel redhat-rpm-config glib2-devel gdk-pixbuf2-devel inkscape gtk-murrine-engine google-roboto-mono-fonts google-roboto-fonts
            sudo gem install sass
            cd ~/src && git clone --depth 1 https://github.com/Ferdi265/numix-solarized-gtk-theme.git && cd numix-solarized-grk-theme && sudo make THEME=SolarizedDarkBlue install
		fi
	;;
esac
