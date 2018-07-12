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
fi

#==============================================================================
# Go
#==============================================================================
export GOPATH=${HOME}/Code/go
PATH=${PATH}:$(go env GOPATH)/bin

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
eval "$(rbenv init -)"

#==============================================================================
# OPAM configuration
#==============================================================================
. ${HOME}/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true

#==============================================================================
# nvm
#==============================================================================
if [ -e /usr/local/opt/nvm ]; then
  export NVM_DIR="$XDG_DATA_HOME/nvm"
  nvm_default_version="v$(cat "${NVM_DIR}/alias/default")"
  PATH="${NVM_DIR}/versions/node/${nvm_default_version}/bin:${PATH}"
  export MANPATH="${NVM_DIR}/versions/node/${nvm_default_version}/share/man:${MANPATH}"
  export NODE_PATH="${NVM_DIR}/versions/node/${nvm_default_version}/lib/node_modules"
  nvm () { # for lazy loading
    unset -f nvm
    source "/usr/local/opt/nvm/nvm.sh"

    nvm "$@"
  }
fi

#==============================================================================
# Editor
#==============================================================================
export VISUAL=/usr/local/bin/nvim
export EDITOR=/usr/local/bin/nvim
alias vi=nvim
alias vim=nvim

if (which zprof > /dev/null 2>&1) ;then
  zprof
fi

# Export
export PATH
