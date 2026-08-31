#!/bin/bash

ROOT="$(cd "${BASH_SOURCE%/*}" || exit 1; pwd)"

install_latest() {
  local -r SRC_URL="$1"
  local -r DEST_DIR="$2"
  local -r BRANCH="$3"

  if [[ -e "$DEST_DIR" ]]; then
    cd "$DEST_DIR" || exit 1
    git pull
  else
    if [[ -z "$BRANCH" ]]; then
      git clone --depth=1 "$SRC_URL" "$DEST_DIR"
    else
      git clone --depth=1 "$SRC_URL" "$DEST_DIR" --branch "$BRANCH"
    fi
  fi
}

install_zplug() {
  install_latest \
    https://github.com/zplug/zplug \
    "$HOME/.local/share/zplug"
}

install_starship() {
  curl -sSL https://starship.rs/install.sh | sh -s -- -y -b "$HOME/.local/bin"
}

install_mise() {
  curl -L https://mise.run | sh
}

install_base16_shell() {
  install_latest \
    https://github.com/chriskempson/base16-shell.git \
    "$HOME/.local/share/base16-shell"
}

install_tmux_themepack() {
  install_latest \
    https://github.com/jimeh/tmux-themepack.git \
    "$HOME/.local/share/tmux-themepack"
}

install_nvim() {
  if [ "$(uname)" == 'Darwin' ]; then
    local TEMP_DIR="$(mktemp -d -t -diskkid-install-sh)"
    local FILE_NAME="nvim-macos-arm64.tar.gz"
  else
    local TEMP_DIR="$(mktemp -d --suffix -diskkid-install-sh)"
    local FILE_NAME="nvim-linux-x86_64.appimage"
  fi
  trap "rm -rf '$TEMP_DIR'" EXIT

  echo "Installing $FILE_NAME"

  cd "$TEMP_DIR" || exit 1
  curl -LO https://github.com/neovim/neovim/releases/latest/download/"$FILE_NAME"

  if [ "$(uname)" == 'Darwin' ]; then
    tar xf "$FILE_NAME"
    mv nvim-macos-arm64 "$HOME/.local/share/nvim"
    ln_if_not_exist "$HOME/.local/share/nvim/bin/nvim" "$HOME/.local/bin/nvim"
  else
    chmod u+x "$FILE_NAME"
    mv "$FILE_NAME" "$HOME/.local/bin/nvim"
  fi
}

ln_if_not_exist() {
  if [ -e "$2" ]; then
    echo "$2 already exists."
  else
    ln -s "$1" "$2"
  fi
}

deploy_config() {
  mkdir -p "$HOME/.config"
  ln_if_not_exist "$ROOT/.tmux.conf"         "$HOME/.tmux.conf"
  ln_if_not_exist "$ROOT/.zshenv"            "$HOME/.zshenv"
  ln_if_not_exist "$ROOT/.config/zsh"        "$HOME/.config/zsh"
  ln_if_not_exist "$ROOT/.config/fish"       "$HOME/.config/fish"
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
  mkdir -p "$HOME/.local/bin"
  install_nvim

  install_zplug &
  install_starship &
  install_mise &

  install_base16_shell &
  install_tmux_themepack &
  wait
fi

if [[ $LINK != "" ]]; then
  deploy_config
fi
