# See https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
set -x XDG_DATA_HOME   $HOME/.local/share
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_CACHE_HOME  $HOME/.cache

# For coloring macOS ls
set -x CLICOLOR 1

#==============================================================================
# PATH
#==============================================================================
set PATH $HOME/.bin $HOME/.local/bin $PATH
set PATH /usr/local/sbin $PATH
# Use coreutils
# equivalent to export PATH="$(brew --prefix coreutils)/libexec/gnubin:${PATH}"
if test -e /usr/local/opt/coreutils
  set PATH /usr/local/opt/coreutils/libexec/gnubin $PATH
  set MANPATH /usr/local/opt/coreutils/libexec/gnuman $MANPATH
end

#==============================================================================
# Go
#==============================================================================
if test -e /usr/local/go
  set PATH /usr/local/go/bin $PATH
end

if which go > /dev/null 2>&1
  set -x GOPATH $HOME/Code/go
  set PATH $PATH (go env GOPATH)/bin
end

#==============================================================================
# Rust
#==============================================================================
if which rustc > /dev/null 2>&1
  set PATH $HOME/.cargo/bin $PATH
  set -x RUST_SRC_PATH (rustc --print sysroot)/lib/rustlib/src/rust/src
end

#==============================================================================
# rbenv
#==============================================================================
set -x RBENV_ROOT $XDG_DATA_HOME/rbenv
if test -e $RBENV_ROOT
  set PATH $RBENV_ROOT/bin:$PATH
  status --is-interactive; and source (rbenv init -|psub)
end

#==============================================================================
# nodenv
#==============================================================================
set -x NODENV_ROOT $XDG_DATA_HOME/nodenv
if test -e $NODENV_ROOT
  set PATH $NODENV_ROOT/bin:$PATH
  status --is-interactive; and source (nodenv init -|psub)
end

#==============================================================================
# Editor
#==============================================================================
if type nvim > /dev/null 2>&1
  set -x VISUAL (which nvim)
  set -x EDITOR $VISUAL
  alias vi=nvim
  alias vim=nvim
end

#==============================================================================
# aliases
#==============================================================================
if ls --color=auto > /dev/null 2>&1
  alias ls='ls --color=auto'
end
