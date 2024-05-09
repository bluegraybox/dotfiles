#!/bin/bash

echo "This is totally untested."
exit 1


########## Functions ##########

function install_bashrc {
	local bashrc=$here/bashrc
	local profile=$HOME/.bash_profile
	if [ ! -f $profile ] ; then
		profile=$HOME/.profile
	fi
	echo -e "if [ -f $bashrc ]; then\n	. $bashrc\nfi" >> $profile
}

function install_vim {
	mkdir $HOME/.vim_view
	ln -s $here/vim $HOME/.vim
	pushd $here/vim/bundle/
	git clone git://github.com/scrooloose/syntastic.git
	git clone git://github.com/fatih/vim-go.git
	git clone git://github.com/tpope/vim-markdown.git
	git clone git://github.com/rust-lang/rust.vim.git
	# git clone git://github.com/timcharper/textile.vim.git  # last updated in 2013
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
	ln -s $here/zimwiki/Print.html

	cd $HOME/.config/zim/
	mv style.conf style.conf.orig
	ln -s $here/zimwiki/style.conf
}

########## Main ##########

here=$(realpath -e $(dirname $0))

install_bashrc
install_vim
# install_tmux_conf
# install_zimwiki
