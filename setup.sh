#!/bin/bash

if [ ! -e ./tmux ] ; then
	echo "Installing tmux conf"
	git clone https://github.com/gpakosz/.tmux.git tmux
	ln -s -f "$(pwd)/tmux/.tmux.conf" ~/.tmux.conf
	ln -s -f "$(pwd)/tmux/.tmux.conf.local" ~/.tmux.conf.local
fi

if [ ! -e ~/.vimrc ] ; then
	echo "Installing vim settings"
	ln -s -f "$(pwd)/vim/.vimrc" ~/.vimrc
fi

if [ ! -e ~/.coc.vim ] ; then
	echo "Installing vim code completion settings"
	ln -s -f "$(pwd)/vim/.coc.vim" ~/.coc.vim
fi

if [ ! -e ~/.bash_aliases ] ; then
	echo "Adding pushd aliases"
	ln -s -f "$(pwd)/bash/.bash_aliases" ~/.bash_aliases
fi

if [ ! -e ~/pomodoro.sh ] ; then
	echo "Adding pomodoro.sh"
	ln -s -f "$(pwd)/bash/pomodoro.sh" ~/pomodoro.sh
	chmod +x ~/pomodoro.sh
fi
