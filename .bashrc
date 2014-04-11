# ~/.bashrc: executed by bash(1) for non-login shells.

# if not running interactively, don't do anythin
[[ $- != *i* ]] && return

# Bash won't get SIGWINCH if another process is in the foreground.
# Enable checkwinsize so that bash will check the terminal size when
# it regains control.
# http://cnswww.cns.cwru.edu/~chet/bash/FAQ (E11)
shopt -s checkwinsize

# append to the history file, don't overwrite it
shopt -s histappend

# don't put duplicate lines in the history. See bash(1) for more options
# don't overwrite GNU Midnight Commander's setting of `ignorespace'.
#export HISTCONTROL=$HISTCONTROL${HISTCONTROL+,}ignoredups
# ... or force ignoredups and ignorespace
export HISTCONTROL=ignoreboth

export HISTFILE=~/.cache/bash/bash_history
# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)

# make less more friendly for non-text input files, see lesspipe(1)
#[ -x /usr/bin/lesspipe.sh ] && eval "$(SHELL=/bin/sh lesspipe.sh)"

# Set colorful PS1 only on colorful terminals.
# dircolors --print-database uses its own built-in database
# instead of using /etc/dircolors Try to use the external file
# first to take advantage of user additions. Use internal bash
# globbing instead of external grep binary.

# sanitize TERM:
safe_term=${TERM//[^[:alnum:]]/?}
match_lhs=""

[[ -f /etc/dircolors ]] && match_lhs="${match_lhs}$(</etc/dircolors)"
[[ -f ~/.dircolors ]] && match_lhs="${match_lhs}$(<~/.dircolors)"
[[ -z ${match_lhs} ]] \
  && type -P dircolors >/dev/null \
  && match_lhs=$(dircolors --print-database)

if [[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] ; then
  # we have colors :-)
  color_prompt=yes
else
  color_prompt=
fi
unset safe_term match_lhs

# set a fancy prompt (non-color, unless we know we "want" color)
# case "$TERM" in
#   xterm*|rxvt*|Eterm|aterm|gnome*) color_prompt=yes;;
# esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes
if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  fi
fi
unset force_color_prompt

#NORMAL="\[\e[0m\]"
#RED="\[\e[1;31m\]"
#GREEN="\[\e[1;32m\]"
if [ "$color_prompt" = yes ]; then
  #PS1='\[\e[0;32m\]\u\[\e[m\] \[\e[1;34m\]\w\[\e[m\] \[\e[1;32m\]\$ \[\e[m\] '
  PS1='\[\e[0;32m\]\w\[\e[0m\] \[\e[1;32m\]\$\[\e[0m\] '
else
  PS1='\u@\h \w \$([[ \$? != 0 ]] && echo \":( \")\$ '
fi
unset color_prompt

PS2="> "
PS3="> "
PS4="+ "

if [[ -n $DISPLAY && -x /usr/bin/dircolors && -r $HOME/.dir_colors ]] ; then
  eval $(dircolors -b $HOME/.dir_colors)
fi

# Put all your additions into a separate file like
# ~/.aliases, instead of adding them here directly.
[[ -r ~/.aliases ]] && . ~/.aliases

# Functions to help us manage paths. Second argument is the name of the
# path variable to be modified (default: PATH)
pathremove () {
  local IFS=':'
  local NEWPATH
  local DIR
  local PATHVARIABLE=${2:-PATH}
  for DIR in ${!PATHVARIABLE} ; do
    if [ "$DIR" != "$1" ] ; then
      NEWPATH=${NEWPATH:+$NEWPATH:}$DIR
    fi
  done
  export $PATHVARIABLE="$NEWPATH"
}

pathprepend () {
  pathremove $1 $2
  local PATHVARIABLE=${2:-PATH}
  export $PATHVARIABLE="$1${!PATHVARIABLE:+:${!PATHVARIABLE}}"
}

pathappend () {
  pathremove $1 $2
  local PATHVARIABLE=${2:-PATH}
  export $PATHVARIABLE="${!PATHVARIABLE:+${!PATHVARIABLE}:}$1"
}

# XTerm transpancy
[ -n "$XTERM_VERSION" ] && transset-df -a >/dev/null

## env variable set
$(type -P vim >/dev/null) && export EDITOR=vim

#export CLASSPATH=${CLASSPATH:-.:$JAVA_HOME/lib/tools.jar:$JAVA_HOME/lib/dt.jar}

#ANDROID_SDK=${ANDROID_SDK:-/opt/android-sdk-linux_x86}
#if [ -d $ANDROID_SDK ]; then
#$(type -P android >/dev/null) || pathappend $ANDROID_SDK/tools
#$(type -P adb >/dev/null) || pathappend $ANDROID_SDK/platform-tools
#fi
#unset ANDROID_SDK

if [ -f "$HOME/.pythonrc.py" ]; then
  # export PYTHONSTARTUP=$HOME/.pythonrc.py
  export PYTHONSTARTUP=~/.config/python/python-startup.py
fi

#if [ -f "/usr/local/share/lua/5.1/rlcompleter.lua" ]; then
#    export LUA_INIT=@/usr/local/share/lua/5.1/rlcompleter.lua
#fi

# Setup rbenv
rbenv_BIN=$HOME/.rbenv/bin
pathprepend $rbenv_BIN
eval "$(rbenv init -)"
unset rbenv_BIN

# Setup nvm
[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh # This loads NVM

# Now clean up
unset pathremove pathprepend pathappend
