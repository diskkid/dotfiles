setopt no_global_rcs

export ZDOTDIR=${HOME}/.config/zsh

# See https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
export XDG_DATA_HOME=${HOME}/.local/share
export XDG_CONFIG_HOME=${HOME}/.config
export XDG_CACHE_HOME=${HOME}/.cache

# For coloring macOS ls
export CLICOLOR=1

#==============================================================================
# PATH
#==============================================================================
path=(
  ${HOME}/.bin
  ${HOME}/.local/bin
  /usr/local/sbin
  # Coreutils for mac
  # equivalent to export PATH="$(brew --prefix coreutils)/libexec/gnubin:${PATH}"
  /usr/local/opt/coreutils/libexec/gnubin(N-/)
  # Go
  /usr/local/go/bin(N-/)
  # Rust
  ${HOME}/.cargo/bin(N-/)
  $path
)

# Configure homebrew
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

#==============================================================================
# MANPATH
#==============================================================================
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:${MANPATH}"

#==============================================================================
# Go
#==============================================================================
if type go > /dev/null 2>&1; then
  export GOPATH=${HOME}/Code/go
  PATH=${PATH}:$(go env GOPATH)/bin
fi

#==============================================================================
# Rust
#==============================================================================
if [ -e "$HOME/.cargo" ]; then
  . "$HOME/.cargo/env"
  export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"
fi

#==============================================================================
# asdf
#==============================================================================
. "$XDG_DATA_HOME/asdf/asdf.sh"
fpath=(${XDG_DATA_HOME}/asdf/completions $fpath)

export FZF_DEFAULT_OPTS="--layout=reverse --height=50%"
