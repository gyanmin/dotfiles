#!/bin/sh

#systemd --user &

progname=`basename $0`

message () {
  msg="$progname: $*"
  echo $msg | fold -s -w ${COLUMNS:-80} >&2
}
errormsg () {
  message "$*"
  exit 1
}

errfile=/tmp/xsession-errors
[ -e "$errfile" ] && mv -f "$errfile" "$errfile".0
if ( cp /dev/null "$errfile" 2> /dev/null ) ; then
    chmod 600 "$errfile"
    exec > "$errfile" 2>&1
fi

message "X session started for $LOGNAME at $(date +%s)"

# kill x: ctrl-alt-backspace
setxkbmap -option terminate:ctrl_alt_bksp

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
userxkbmap=$HOME/.Xkbmap

sysresources=/etc/X11/Xresources
sysmodmap=/etc/X11/Xmodmap
sysxkbmap=/etc/X11/Xkbmap

rh6sysresources=/etc/X11/xinit/Xresources
rh6sysmodmap=/etc/X11/xinit/Xmodmap

userxprofile=$HOME/.xprofile
sysxprofile=/etc/xprofile

# merge in defaults
[ -f "$rh6sysresources" ] && xrdb -merge "rh6sysresources"
[ -f "$sysresources" ] && xrdb -merge "$sysresources"
[ -f "$userresources" ] && xrdb -merge "$userresources"
# merge in keymaps
if [ -f "$sysxkbmap" ]; then
    setxkbmap `cat "$sysxkbmap"`
    XKB_IN_USE=yes
fi
if [ -f "$userxkbmap" ]; then
    setxkbmap `cat "$userxkbmap"`
    XKB_IN_USE=yes
fi

#
# Eeek, this seems like too much magic here
#
if [ -z "$XKB_IN_USE" -a ! -L /etc/X11/X ]; then
    if grep '^exec.*/Xsun' /etc/X11/X > /dev/null 2>&1 && [ -f /etc/X11/XF86Config ]; then
        xkbsymbols=`sed -n -e 's/^[    ]*XkbSymbols[   ]*"\(.*\)".*$/\1/p' /etc/X11/XF86Config /etc/X11/xorg.conf`
        if [ -n "$xkbsymbols" ]; then
            setxkbmap -symbols "$xkbsymbols"
            XKB_IN_USE=yes
        fi
    fi
fi

if [ -z "$XKB_IN_USE" ]; then
    [ -f "$rh6sysmodmap" ] && xmodmap "$rh6sysmodmap"
    [ -f "$sysmodmap" ] && xmodmap "$sysmodmap"
    [ -f "$usermodmap" ] && xmodmap "$usermodmap"
fi
unset XKB_IN_USE

# run all system xinitrc shell scripts.
if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for i in /etc/X11/xinit/xinitrc.d/* ; do
        [ -x "$i" ] && . "$i"
    done
fi

[ -f "$sysxprofile" ] && . "$sysxprofile"
[ -f "$userxprofile" ] && . "$userxprofile"

session=${1:-bspwm}
case "$session" in
  xfce4)
    exec startxfce4
    ;;
  gnome)
    exec gnome-session
    ;;
  openbox)
    exec openbox-session
    ;;
  awesome)
    exec awesome
    ;;
  spectrwm)
    exec spectrwm
    ;;
  bspwm)
    exec bspwm
    ;;
  i3)
    exec i3
    ;;
  *)
    xsetroot -solid SteelBlue
    exec xterm -geometry 80x24-0-0
    ;;
esac
