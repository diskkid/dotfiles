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

#==============================================================================
# MANPATH
#==============================================================================
MANPATH="/usr/local/opt/coreutils/libexec/gnuman:${MANPATH}"

#==============================================================================
# GOPATH
#==============================================================================
export GOPATH=${HOME}/Code/go

#==============================================================================
# Rust
#==============================================================================
export RUST_SRC_PATH="$(rustc --print sysroot)/lib/rustlib/src/rust/src"

#==============================================================================
# rbenv
#==============================================================================
export RBENV_ROOT="$XDG_DATA_HOME/rbenv"
if [ -e "$RBENV_ROOT" ]; then
  PATH="${RBENV_ROOT}/bin:${PATH}"
  eval "$(rbenv init -)"
fi

#==============================================================================
# nodenv
#==============================================================================
export NODENV_ROOT="${XDG_DATA_HOME}/nodenv"
if [ -e "$NODENV_ROOT" ]; then
  PATH="${NODENV_ROOT}/bin:${PATH}"
  eval "$(nodenv init -)"
fi

export FZF_DEFAULT_OPTS="--layout=reverse --height=50%"
