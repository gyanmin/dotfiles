# ~/.profile

# Invoked by login shell
# Personal environment variables and startup programs.
if [ -d $HOME/.profile.d/ ] ; then
    for profile in $HOME/.profile.d/*.sh ; do
        [ -r "$profile" ] && . "$profile"
    done
    unset profile
fi

# Start X at login
# [[ -z $DISPLAY && $XDG_VTNR -eq 6 ]] && exec startx

# vim: set et fenc=utf-8 ts=4 sw=4 tw=0 sts=0 :
