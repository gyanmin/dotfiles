# ~/.bashrc: executed by bash(1) for non-login shells.

# if not running interactively, don't do anythin
[[ $- != *i* ]] && return

shopt -s checkwinsize
shopt -s histappend
export HISTFILE=~/.cache/bash/bash_history
export HISTSIZE=2000
export HISTFILESIZE=2000
export HISTCONTROL=ignoreboth
#export HISTIGNORE="cd *:ls:ls *:history*:cat *:clear"

export EDITOR=vim

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
[[ -z ${match_lhs} ]] && type -P dircolors >/dev/null \
  && match_lhs=$(dircolors --print-database)

if [[ $'\n'${match_lhs} == *$'\n'"TERM "${safe_term}* ]] ; then
  # we have colors :-)
  color_prompt=yes
else
  color_prompt=
fi
unset safe_term match_lhs

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
if [ "$color_prompt" = "yes" ]; then
  PS1='\[\e[0;32m\]\w\[\e[0m\] \[\e[1;32m\]\$\[\e[0m\] '
else
  PS1='\u@\h \w \$([[ \$? != 0 ]] && echo \":( \")\$ '
fi
unset color_prompt

# PS2="> "
# PS3="> "
# PS4="+ "

if [[ -n $DISPLAY && -x /usr/bin/dircolors && -r $HOME/.dircolors.256 ]] ; then
  eval $(dircolors -b $HOME/.dircolors.256)
fi

# ~/.aliases
[[ -r ~/.aliases ]] && . ~/.aliases

# gitprompt configuration
# Set config variables first
# GIT_PROMPT_ONLY_IN_REPO=1

# as last entry source the gitprompt script
# source ~/.bash-git-prompt/gitprompt.sh

if [ -f "$HOME/.pythonrc.py" ]; then
  export PYTHONSTARTUP=~/.config/python/python-startup.py
fi

# Setup rbenv
rbenv_BIN=$HOME/.rbenv/bin
[[ -d $rbenv_BIN ]] && export PATH=$rbenv_BIN:$PATH
eval "$(rbenv init -)"
unset rbenv_BIN

# Setup nvm
# [[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh # This loads NVM

# [[ -d ~/.scripts ]] && export PATH=~/.scripts:$PATH

# XTerm transpancy
# [[ -n "$XTERM_VERSION" ]] && transset-df -a >/dev/null

[[ -r /usr/share/doc/pkgfile/commdnd-not-found.bash ]] && source /usr/share/doc/pkgfile/command-not-found.bash
# [[ -z $TMUX ]] && tmux
