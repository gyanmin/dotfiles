# ~/.zprofile for a login shell

# Personal environment variables and startup programs.
# environment variables and startup programs are in /etc/zprofile.

[ -r ~/.profile ] && . ~/.profile
# typeset -U path
# path=(${HOME}/.local/bin ${HOME}/bin $path)
if [[ $EUID != 0 ]]; then
    typeset -xT SUDO_PATH sudo_path
    typeset -U sudo_path
    sudo_path=({,/usr/local,/usr}/sbin(N-/))
    alias sudo="sudo env PATH=\"SUDO_PATH:$PATH\""
fi
