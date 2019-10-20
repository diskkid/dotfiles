#==============================================================================
# zplug
#==============================================================================
export ZPLUG_HOME=${XDG_DATA_HOME:-$HOME/.local/share}/zplug
source $ZPLUG_HOME/init.zsh

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "b4b4r07/enhancd", use:init.sh
export ENHANCD_FILTER=fzf:peco

zplug "denysdovhan/spaceship-zsh-theme", use:spaceship.zsh, as:theme
SPACESHIP_PROMPT_ORDER=(
  time          # Time stampts section
  user          # Username section
  host          # Hostname section
  dir           # Current directory section
  git           # Git section (git_branch + git_status)
# hg            # Mercurial section (hg_branch  + hg_status)
# package       # Package version
  node          # Node.js section
  ruby          # Ruby section
# elixir        # Elixir section
  xcode         # Xcode section
  swift         # Swift section
  golang        # Go section
# php           # PHP section
  rust          # Rust section
  haskell       # Haskell Stack section
# julia         # Julia section
  docker        # Docker section
# aws           # Amazon Web Services section
  venv          # virtualenv section
  conda         # conda virtualenv section
  pyenv         # Pyenv section
# dotnet        # .NET section
# ember         # Ember.js section
# exec_time     # Execution time
  line_sep      # Line break
# battery       # Battery level and status
# vi_mode       # Vi-mode indicator
# jobs          # Backgound jobs indicator
  exit_code     # Exit code section
  char          # Prompt character
)

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
  BUFFER=$(history -n 1 -1 | fzf)
  CURSOR=$#BUFFER
  zle -Rc
}

zle -N select_history
bindkey '^R' select_history

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

# Export
export PATH
