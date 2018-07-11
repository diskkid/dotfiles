# See https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_DATA_HOME=${HOME}/.local/share
export XDG_CONFIG_HOME=${HOME}/.config
export XDG_CACHE_HOME=${HOME}/.cache

export CLICOLOR=1

autoload -U compinit
compinit -d ${XDG_CACHE_HOME}/.zcompdump

setopt prompt_subst

#==============================================================================
# PATH
#==============================================================================
export PATH="${HOME}/.bin:${PATH}"
export PATH="/usr/local/sbin:${PATH}"
# Use coreutils
export PATH="$(brew --prefix coreutils)/libexec/gnubin:${PATH}"

#==============================================================================
# Go
#==============================================================================
export GOPATH=${HOME}/Code/go
export PATH=${PATH}:$(go env GOPATH)/bin

#==============================================================================
# Rust
#==============================================================================
export PATH="${HOME}/.cargo/bin:${PATH}"


#==============================================================================
# zplug
#==============================================================================
export ZPLUG_HOME=${XDG_DATA_HOME}/zplug
source ${ZPLUG_HOME}/init.zsh

zplug "zsh-users/zsh-syntax-highlighting"
zplug "zsh-users/zsh-autosuggestions"

zplug "denysdovhan/spaceship-zsh-theme", use:spaceship.zsh, from:github, as:theme
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
eval "$(rbenv init -)"

#==============================================================================
# OPAM configuration
#==============================================================================
. /Users/cuckookettle/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

#==============================================================================
# nvm
#==============================================================================
export NVM_DIR="$HOME/.nvm"
. "/usr/local/opt/nvm/nvm.sh"

#==============================================================================
# Editor
#==============================================================================
export VISUAL=/usr/local/bin/nvim
export EDITOR=/usr/local/bin/nvim
alias vi=nvim
alias vim=nvim
