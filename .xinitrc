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

ERRFILE=$HOME/.xsession-errors
[[ -e "$ERRFILE" ]] && mv -f "$ERRFILE" "$ERRFILE".0
exec > "$ERRFILE" 2>&1

message "X session started for $LOGNAME at $(date +%s)"

USERSESSIONDIR=$HOME/.xinitrc.d
if [ -d $USERSESSIONDIR ] ; then
  # message "loading user xinitrc"
  for i in $USERSESSIONDIR/* ; do
    [[ -x $i ]] && . $i
  done
  unset i
  # message "user xinitrc loaded"
fi

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
    # sxhkd &
    exec bspwm
    ;;
  *)
    xsetroot -solid SteelBlue
    exec xterm -geometry 80x24-0-0
    ;;
esac
