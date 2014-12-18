# zsh profiling
# load .zshrc.pre to give the user the chance to overwrite the defaults
[[ -r ${ZDOTDIR:-${HOME}}/.zshrc.pre ]] && source ${ZDOTDIR:-${HOME}}/.zshrc.pre

# color theme
# Base16 Shell
# BASE16_SCHEME="solarized"
# BASE16_SHELL="$HOME/.config/base16-shell/base16-$BASE16_SCHEME.dark.sh"
# [[ -s $BASE16_SHELL ]] && . $BASE16_SHELL

# ----------------------------------
# History stuff
# ----------------------------------
HISTFILE=~/.cache/zsh/zsh_histfile
HISTSIZE=2000
SAVEHIST=$HISTSIZE

# ----------------------------------
# Variables
# ----------------------------------
# typeset -U path
# path=(${HOME}/.local/bin ${HOME}/bin $path)
typeset -U fpath
fpath=(${HOME}/.local/share/zsh/site-functions $fpath)

# ----------------------------------
# Dircolors
# ----------------------------------
DIRCOLORS="${HOME}/.dircolors.256"
[ -r $DIRCOLORS ] && eval $(dircolors $DIRCOLORS)
unset DIRCOLORS

# -----------------------------------
# Keybindings
# -----------------------------------
# bindkey -v        # guess by $EDITOR

# -----------------------------------
# Alias stuff
# -----------------------------------
[ -r ${ZDOTDIR:-${HOME}}/.aliases ] && source ${ZDOTDIR:-${HOME}}/.aliases

# -----------------------------------
# Shell funcs
# -----------------------------------
# man () {}

# -----------------------------------
# Comp stuff
# -----------------------------------
zmodload zsh/complist
autoload -Uz compinit
compinit -d '${XDG_CACHE_HOME}/zsh/zcompdump'
zstyle :compinstall filename '${ZDOTDIR:-${HOME}}/.zshrc'

# sections completion!
# zstyle ':completion:*' verbose yes
# zstyle ':completion:*' menu select=2
# zstyle ':completion:*' use-cache on
# zstyle ':completion:*' cache-path '${XDG_CACHE_HOME}/zsh/cache'
zstyle ':completion:*' matcher-list '' '+m:{a-z}={A-Z}' '+m:{A-Z}={a-z}'
zstyle ':completion:*:default' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
# zstyle ':completion:*' group-name ''

# fuzzy matching of completions for when you mistype them:
zstyle ':completion:*' completer _complete _match _approximate
zstyle ':completion:*:match:*' original only
zstyle ':completion:*:approximate:*' max-errors 1 numeric

# ignore completion functions for commands you don't have:
zstyle ':completion:*:functions' ignored-patterns '_*'

# completing process IDs with menu selection:
zstyle ':completion:*:*kill:*' menu yes select
zstyle ':completion:*:kill:*' force-list always
zstyle ':completion:*:sudo:*' environ PATH="$SUDO_PATH:$PATH"

# if you end up using a directory as argument, this will remove the trailing slash (usefull in ln):
zstyle ':completion:*' squeeze-slashes true

# -----------------------------------
# Window title
# -----------------------------------
# case $TERM in
#     termite|*xterm*|rxvt|rxvt-unicode|rxvt-256color|rxvt-unicode-256color|(dt|k|E)term)
#         precmd () {
#             vcs_info
#             print -Pn "\e]0;[%n@%M][%~]%#\a"
#         }
#         preexec () { print -Pn "\e]0;[%n@%M][%~]%# ($1)\a" }
#         ;;
#     screen|screen-256color)
#         precmd () {
#             vcs_info
#             print -Pn "\e]83;title \"$1\"\a"
#             print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~]\a"
#         }
#         preexec () {
#             print -Pn "\e]83;title \"$1\"\a"
#             print -Pn "\e]0;$TERM - (%L) [%n@%M]%# [%~] ($1)\a"
#         }
#         ;;
# esac

# -----------------------------------
# Prompt
# -----------------------------------
autoload -Uz promptinit
promptinit
prompt walters
prompt off

# autoload -U colors zsh/terminfo
# colors
# autoload -Uz vcs_info
# zstyle ':vcs_info:*' enable git hg
# zstyle ':vcs_info:*' check-for-changes true
# zstyle ':vcs_info:git*' formats "%{${fg[cyan]}%}[%{${fg[green]}%}%s%{${fg[cyan]}%}][%{${fg[blue]}%}%r/%S%%{${fg[cyan]}%}][%{${fg[blue]}%}%b%{${fg[yellow]}%}%m%u%c%{${fg[cyan]}%}]%{$reset_color%}"

# -----------------------------------
# Various
# -----------------------------------
setopt no_hup
setopt inc_append_history
setopt hist_ignore_all_dups
setopt hist_ignore_space

# setopt auto_list
# setopt auto_menu
setopt complete_aliases
setopt always_to_end
setopt complete_in_word
# setopt correct
setopt list_ambiguous

setopt auto_cd
setopt correct_all

setopt no_beep
# setopt no_hist_beep
# setopt no_list_beep

# -----------------------------------
# [[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh

cmdnotfound="/usr/share/doc/pkgfile/command-not-found.zsh"
zshsyntaxhi="/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
rcs=("$cmdnotfound" "$zshsyntaxhi")
for rc in $rcs ; do
    [ -r $rc ] && . $rc
done
unset rc rcs zshsyntaxhi cmdnotfound
