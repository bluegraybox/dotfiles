#!/bin/bash

echo "This is totally untested."
exit 1


########## Functions ##########

function install_bashrc {
	local bashrc=$HOME/dotfiles/bashrc
	echo -e "if [ -f $bashrc ]; then\n	. $bashrc\nfi" >> $HOME/.bash_profile
}

function install_vim {
	mkdir $HOME/.vim_view
	ln -s $HOME/dotfiles/vim $HOME/.vim
	pushd $HOME/dotfiles/vim/bundle/
	git clone https://github.com/scrooloose/syntastic.git
	git clone https://github.com/fatih/vim-go.git
	git clone git://github.com/tpope/vim-markdown.git
	git clone git://github.com/timcharper/textile.vim.git
	# git clone https://github.com/rust-lang/rust.vim.git
	# git clone git://github.com/kchmck/vim-coffee-script.git
	# git clone git://github.com/nono/vim-handlebars.git
	popd
}

function install_tmux_conf {
	local dest=$HOME/.tmux.conf
	if [ -e $dest ] ; then
		echo "$dest already exists!"
	else
		cp -p $here/tmux.conf $dest
	fi
}

function install_zimwiki {
	# This will only work if ZimWiki is already set up
	cd $HOME/.local/share/zim/templates/html/
	mv Print.html Print.html.orig
	ln -s $HOME/dotfiles/zimwiki/Print.html

	cd $HOME/.config/zim/
	mv style.conf style.conf.orig
	ln -s $HOME/dotfiles/zimwiki/style.conf
}

########## Main ##########

here=$(realpath -e $(dirname $0))

install_bashrc
install_vim
install_tmux_conf
# install_zimwiki
