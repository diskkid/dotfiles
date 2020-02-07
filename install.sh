#!/bin/bash

ROOT="$(cd "${BASH_SOURCE%/*}" || exit 1; pwd)"

install_latest() {
  local src_url="$1"
  local dest_dir="$2"

  if [[ -e "$dest_dir" ]]; then
    cd "$dest_dir" || exit 1
    git pull
  else
    git clone --depth=1 "$src_url" "$dest_dir"
  fi
}

install_zplug () {
  install_latest \
    https://github.com/zplug/zplug \
    "$HOME/.local/share/zplug"
}

install_vim_plug () {
  curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
}

install_rbenv () {
  install_latest \
    https://github.com/rbenv/rbenv.git \
    "$HOME/.local/share/rbenv"
}

install_ruby_build () {
  install_latest \
    https://github.com/rbenv/ruby-build.git \
    "$HOME/.local/share/rbenv/plugins/ruby-build"
}

install_nodenv () {
  install_latest \
    https://github.com/nodenv/nodenv.git \
    "$HOME/.local/share/nodenv"
}

install_node_build () {
  install_latest \
    https://github.com/nodenv/node-build.git \
    "$HOME/.local/share/nodenv/plugins/node-build"
}

install_jetbrains_npm () {
  install_latest \
    https://github.com/nodenv/jetbrains-npm.git \
    "$HOME/.local/share/nodenv/lib/node_modules/npm"
}

install_tmux_themepack () {
  install_latest \
    https://github.com/jimeh/tmux-themepack.git \
    "$HOME/.local/share/tmux-themepack"
}

ln_if_not_exist () {
  if [ -e "$2" ]; then
    echo "$2 already exists."
  else
    ln -s "$1" "$2"
  fi
}

deploy_config () {
  mkdir -p "$HOME/.config"
  ln_if_not_exist "$ROOT/.tmux.conf"         "$HOME/.tmux.conf"
  ln_if_not_exist "$ROOT/.zshenv"            "$HOME/.zshenv"
  ln_if_not_exist "$ROOT/.config/zsh"        "$HOME/.config/zsh"
  ln_if_not_exist "$ROOT/.config/nvim"       "$HOME/.config/nvim"
  ln_if_not_exist "$ROOT/.config/git"        "$HOME/.config/git"
  ln_if_not_exist "$ROOT/.config/polybar"    "$HOME/.config/polybar"
  ln_if_not_exist "$ROOT/.config/i3"         "$HOME/.config/i3"
  ln_if_not_exist "$ROOT/.config/alacritty"  "$HOME/.config/alacritty"
  ln_if_not_exist "$ROOT/.config/fontconfig" "$HOME/.config/fontconfig"
  ln_if_not_exist "$ROOT/.config/dunst"      "$HOME/.config/dunst"
  ln_if_not_exist "$ROOT/.config/rofi"       "$HOME/.config/rofi"

  ln_if_not_exist "$ROOT/.xsession" "$HOME/.xsession"
  ln_if_not_exist "$ROOT/.xkb"      "$HOME/.xkb"

  mkdir -p "$HOME/.config/Code/User"
  mkdir -p "$HOME/.config/Code - OSS/User"
  ln_if_not_exist "$ROOT/.config/Code/User/settings.json" "$HOME/.config/Code/User/settings.json"
  ln_if_not_exist "$ROOT/.config/Code/User/settings.json" "$HOME/.config/Code - OSS/User/settings.json"
}

usage() {
  cat <<USAGE
Usage: $0 [-i] [-l]
  -i: Install
  -l: Make symbolic links to configuration files
USAGE
  exit 1
}

if [[ $# = 0 ]]; then
  usage
fi

while getopts il OPT
do
  case $OPT in
    "i" )
      INSTALL="TRUE" ;;
    "l" )
      LINK="TRUE" ;;
    * )
      usage ;;
  esac
done

if [[ $INSTALL != "" ]]; then
  install_zplug &
  install_vim_plug &
  install_rbenv &
  install_ruby_build &
  install_nodenv &
  install_node_build &
  install_jetbrains_npm &
  install_tmux_themepack &
  wait
fi
if [[ $LINK != "" ]]; then
  deploy_config
fi
