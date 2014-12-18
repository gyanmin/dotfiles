#!/bin/sh

BACKDIR=`pwd`
files="${HOME}/.xinitrc ${HOME}/.Xresources ${HOME}/.profile ${HOME}/.xprofile"
files="$files ${HOME}/.bash_profile ${HOME}/.bashrc ${HOME}/.bash_login ${HOME}/.bash_logout"
files="$files ${HOME}/.zshenv ${HOME}/.zprofile ${HOME}/.zshrc"
files="$files ${HOME}/.vimrc ${HOME}/.vim/vimrc"
files="$files ${XDG_CONFIG_HOME}/bspwm/bspwmrc"

for f in $files ; do
    [ -f $f ] && rsync -a ${f} ${BACKDIR}
done
unset f
