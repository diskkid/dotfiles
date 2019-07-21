# See https://specifications.freedesktop.org/basedir-spec/basedir-spec-latest.html
set -x XDG_DATA_HOME   $HOME/.local/share
set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_CACHE_HOME  $HOME/.cache

# For coloring macOS ls
set -x CLICOLOR 1

# Base16 Shell
if status --is-interactive
  set BASE16_SHELL "$HOME/.config/base16-shell/"
  source "$BASE16_SHELL/profile_helper.fish"
end

#==============================================================================
# PATH
#==============================================================================
set -p PATH $HOME/.bin $HOME/.local/bin
set -p PATH /usr/local/sbin
# Use coreutils
# equivalent to export PATH="$(brew --prefix coreutils)/libexec/gnubin:${PATH}"
if test -e /usr/local/opt/coreutils
  set -p PATH /usr/local/opt/coreutils/libexec/gnubin
  set -p MANPATH /usr/local/opt/coreutils/libexec/gnuman
end

#==============================================================================
# Go
#==============================================================================
if test -e /usr/local/go
  set -p PATH /usr/local/go/bin
end

if which go > /dev/null 2>&1
  set -x GOPATH $HOME/Code/go
  set -p PATH (go env GOPATH)/bin
end

#==============================================================================
# Rust
#==============================================================================
set -p PATH $HOME/.cargo/bin
if which rustc > /dev/null 2>&1
  set -x RUST_SRC_PATH (rustc --print sysroot)/lib/rustlib/src/rust/src
end

#==============================================================================
# Haskell
#==============================================================================
set -p PATH $HOME/.cabal/bin
set -p PATH $HOME/.ghcup/bin

#==============================================================================
# rbenv
#==============================================================================
set -x RBENV_ROOT $XDG_DATA_HOME/rbenv
if test -e $RBENV_ROOT
  set -p PATH $RBENV_ROOT/bin
  status --is-interactive; and source (rbenv init -|psub)
end

#==============================================================================
# nodenv
#==============================================================================
set -x NODENV_ROOT $XDG_DATA_HOME/nodenv
if test -e $NODENV_ROOT
  set -p PATH $NODENV_ROOT/bin
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

alias less='less -R'

function fish_user_key_bindings
	fzf_key_bindings
end

# Base16 Shell
if status --is-interactive
    set BASE16_SHELL "$HOME/.config/base16-shell/"
    source "$BASE16_SHELL/profile_helper.fish"
end

set color00 "181818" # Base 00 - Black
set color01 "ab4642" # Base 08 - Red
set color02 "a1b56c" # Base 0B - Green
set color03 "f7ca88" # Base 0A - Yellow
set color04 "7cafc2" # Base 0D - Blue
set color05 "ba8baf" # Base 0E - Magenta
set color06 "86c1b9" # Base 0C - Cyan
set color07 "d8d8d8" # Base 05 - White
set color08 "585858" # Base 03 - Bright Black
set color09 $color01 # Base 08 - Bright Red
set color10 $color02 # Base 0B - Bright Green
set color11 $color03 # Base 0A - Bright Yellow
set color12 $color04 # Base 0D - Bright Blue
set color13 $color05 # Base 0E - Bright Magenta
set color14 $color06 # Base 0C - Bright Cyan
set color15 "f8f8f8" # Base 07 - Bright White
set color16 "dc9656" # Base 09
set color17 "a16946" # Base 0F
set color18 "282828" # Base 01
set color19 "383838" # Base 02
set color20 "b8b8b8" # Base 04
set color21 "e8e8e8" # Base 06
set color_foreground "d8d8d8" # Base 05
set color_background "181818" # Base 00

set -u fish_color_normal $color07
set -u fish_color_command $color02
set -u fish_color_quote $color06
set -u fish_color_redirection $color06
set -u fish_color_end $color08
set -u fish_color_error $color01
set -u fish_color_param $color03
set -u fish_color_comment $color08
set -u fish_color_match $color02
set -u fish_color_selection $color03
set -u fish_color_search_match $color02
set -u fish_color_operator $color07
set -u fish_color_escape $color07
set -u fish_color_cwd $color07
set -u fish_color_autosuggestion $color08
set -u fish_color_user $color07
set -u fish_color_host $color07
set -u fish_color_cancel $color07
