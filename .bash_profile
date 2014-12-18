# ~/.bash_profile

# Personal environment variables and startup programs.
# environment variables and startup programs are in /etc/profile.

[ -r ~/.profile ] && . ~/.profile
[ -r ~/.bashrc ] && . ~/.bashrc

# [[ -z $DISPLAY ]] && export LANG=C && export LC_CTYPE=en_US.UTF-8

# vim: set et fenc=utf-8 ts=4 sw=4 tw=0 sts=0 :
