#==============================================================================
# Color
#==============================================================================
set theme_color_scheme base16

set fish_color_normal         brwhite
set fish_color_autosuggestion brblack
set fish_color_cancel         brcyan
set fish_color_command        brpurple
set fish_color_comment        brblack
set fish_color_cwd            brred
set fish_color_end            brwhite
set fish_color_error          brred
set fish_color_escape         brcyan
set fish_color_host           brgreen
set fish_color_host_remote    bryellow
set fish_color_match          brcyan --underline
set fish_color_operator       brpurple
set fish_color_param          brred
set fish_color_quote          brgreen
set fish_color_redirection    brcyan
set fish_color_search_match   --background=brblack
set fish_color_selection      --background=brblack
set fish_color_user           brblue

set fish_pager_color_progress              brblack --italics
set fish_pager_color_secondary_background  # null
set fish_pager_color_secondary_completion  brblack
set fish_pager_color_secondary_description brblack
set fish_pager_color_secondary_prefix      brblack
set fish_pager_color_selected_background   --background=brblack
set fish_pager_color_selected_completion   bryellow
set fish_pager_color_selected_description  bryellow
set fish_pager_color_selected_prefix       bryellow

# For coloring macOS ls
export CLICOLOR=1

set -x XDG_CONFIG_HOME $HOME/.config
set -x XDG_CACHE_HOME $HOME/.cache
set -x XDG_DATA_HOME $HOME/.local/share

#==============================================================================
# PATH
#==============================================================================
set -x PATH \
  $HOME/.bin \
  $HOME/.local/bin \
  /usr/local/sbin \
  # Coreutils for mac
  # equivalent to export PATH="$(brew --prefix coreutils)/libexec/gnubin:$PATH"
  /usr/local/opt/coreutils/libexec/gnubin \
  # Go
  /usr/local/go/bin \
  # Rust
  $HOME/.cargo/bin \
  $HOME/.ghcup/bin \
  $HOME/.cabal/bin \
  $PATH

#==============================================================================
# MANPATH
#==============================================================================
set -x MANPATH "/usr/local/opt/coreutils/libexec/gnuman" $MANPATH

#==============================================================================
# Go
#==============================================================================
if type go > /dev/null 2>&1
  set -x GOPATH $HOME/Code/go
  set -g PATH (go env GOPATH)/bin $PATH
end

#==============================================================================
# Rust
#==============================================================================
if type rustc > /dev/null 2>&1
  set -x RUST_SRC_PATH (rustc --print sysroot)/lib/rustlib/src/rust/src
  set -x CARGO_TARGET_DIR $XDG_DATA_HOME/rust/target
end

#==============================================================================
# rbenv
#==============================================================================
set -x RBENV_ROOT "$XDG_DATA_HOME/rbenv"
if test -e "$RBENV_ROOT"
  set -g PATH "$RBENV_ROOT/bin" $PATH
  status --is-interactive; and rbenv init - | source
end

#==============================================================================
# nodenv
#==============================================================================
set -x NODENV_ROOT "$XDG_DATA_HOME/nodenv"
if test -e "$NODENV_ROOT"
  set -g PATH "$NODENV_ROOT/bin" $PATH
  status --is-interactive; and source (nodenv init -|psub)
end

if type nvim > /dev/null 2>&1
  set -x EDITOR nvim
  alias vim='nvim'
  alias vi='nvim'
end

if type exa > /dev/null 2>&1
  alias ls=exa
end
