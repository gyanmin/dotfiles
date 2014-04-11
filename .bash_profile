# ~/.bash_profile

# Personal environment variables and startup programs.
# environment variables and startup programs are in /etc/profile.

# Start X at login
[[ -z $DISPLAY && $XDG_VTNR -eq 6 ]] && exec startx

test -r ~/.bashrc && . ~/.bashrc

# vim: set et fenc=utf-8 ts=4 sw=4 tw=0 sts=0 :
