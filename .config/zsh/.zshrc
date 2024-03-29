# Base16
BASE16_SHELL="$HOME/.local/share/base16-shell/"
[ -n "$PS1" ] && \
    [ -s "$BASE16_SHELL/profile_helper.sh" ] && \
        source "$BASE16_SHELL/profile_helper.sh"

base16_eighties

#==============================================================================
# zplug
#==============================================================================
export ZPLUG_HOME=${XDG_DATA_HOME:-$HOME/.local/share}/zplug
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "b4b4r07/enhancd", use:init.sh
export ENHANCD_FILTER=fzf:peco

if ! zplug check --verbose; then
  printf "Install? [y/N]: "
  if read -q; then
    echo; zplug install
  fi
fi

zplug load

#==============================================================================
# zsh options
#==============================================================================
export WORDCHARS='*?_-.[]~=&;!#$%^(){}<>'
setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_no_store
setopt share_history
mkdir -p ${XDG_CACHE_HOME:-$HOME/.cache}/zsh
HISTFILE=${XDG_CACHE_HOME:-$HOME/.cache}/zsh/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
touch $HISTFILE

function select_history () {
  if type peco > /dev/null 2>&1; then
    BUFFER=$(history -n 1 -1 | peco)
  elif type peco > /dev/null 2>&1; then
    BUFFER=$(history -n 1 -1 | fzf)
  fi

  CURSOR=$#BUFFER
  zle -Rc
}

zle -N select_history
bindkey '^R' select_history
bindkey -e

#==============================================================================
# Editor
#==============================================================================
if type nvim > /dev/null 2>&1; then
  export VISUAL=$(which nvim)
  export EDITOR=$VISUAL
  alias vi=nvim
  alias vim=nvim
fi

#==============================================================================
# aliases
#==============================================================================
if type exa > /dev/null 2>&1; then
  alias ls=exa
elif ls --color=auto > /dev/null 2>&1; then
  alias ls='ls --color=auto'
fi

# Performance measurement
if type zprof > /dev/null 2>&1; then
  zprof
fi

alias less='less -R'

stty -ixon # Disable ctrl-c and ctrl-q

# Starship
eval "$(starship init zsh)"
