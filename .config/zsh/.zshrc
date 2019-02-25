# See https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_DATA_HOME=${HOME}/.local/share
export XDG_CONFIG_HOME=${HOME}/.config
export XDG_CACHE_HOME=${HOME}/.cache

# For coloring macOS ls
export CLICOLOR=1

#==============================================================================
# PATH
#==============================================================================
PATH="${HOME}/.bin:${PATH}"
PATH="/usr/local/sbin:${PATH}"
# Use coreutils
# equivalent to export PATH="$(brew --prefix coreutils)/libexec/gnubin:${PATH}"
if [ -e /usr/local/opt/coreutils ]; then
  PATH="/usr/local/opt/coreutils/libexec/gnubin:${PATH}"
  MANPATH="/usr/local/opt/coreutils/libexec/gnuman:${MANPATH}"
fi

#==============================================================================
# Go
#==============================================================================
which go > /dev/null
if [ $? -eq 0 ]; then
  export GOPATH=${HOME}/Code/go
  PATH=${PATH}:$(go env GOPATH)/bin
fi

#==============================================================================
# Rust
#==============================================================================
PATH="${HOME}/.cargo/bin:${PATH}"

#==============================================================================
# zplug
#==============================================================================
export ZPLUG_HOME=${XDG_DATA_HOME}/zplug
source ${ZPLUG_HOME}/init.zsh

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"
zplug "b4b4r07/enhancd", use:init.sh
export ENHANCD_FILTER=peco

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
# rbenv
#==============================================================================
export RBENV_ROOT="$XDG_DATA_HOME/rbenv"
if [ -e "$RBENV_ROOT" ]; then
  PATH="${RBENV_ROOT}/bin:${PATH}"
  eval "$(rbenv init -)"
fi

#==============================================================================
# OPAM configuration
#==============================================================================
. ${HOME}/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

#==============================================================================
# nodenv
#==============================================================================
export NODENV_ROOT="${XDG_DATA_HOME}/nodenv"
if [ -e "$NODENV_ROOT" ]; then
  PATH="${NODENV_ROOT}/bin:${PATH}"
  eval "$(nodenv init -)"
fi

#==============================================================================
# zsh options
#==============================================================================

setopt hist_ignore_all_dups
setopt hist_reduce_blanks
setopt hist_no_store
setopt share_history
mkdir -p ${XDG_CACHE_HOME}/zsh
HISTFILE=${XDG_CACHE_HOME}/zsh/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
touch $HISTFILE

function select_history () {
  BUFFER=$(history -nr 1 -1 | peco --query "$LBUFFER")
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
ls --color=auto > /dev/null 2>&1
if [ $? -eq 0 ]; then
  alias ls='ls --color=auto'
fi

# Performance measurement
if (which zprof > /dev/null 2>&1) ;then
  zprof
fi

# Export
export PATH
