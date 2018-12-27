#!/bin/bash

ROOT="$(cd $(dirname $0); pwd)"

install_zplug () {
  local zplug_dir=${HOME}/.local/share/zplug
  if [ ! -e ${zplug_dir} ]; then
    git clone https://github.com/zplug/zplug ${zplug_dir}
  fi
}

install_dein () {
  local dein_dir=${HOME}/.local/share/dein/repos/github.com/Shougo/dein.vim
  if [ ! -e ${dein_dir} ]; then
    git clone https://github.com/Shougo/dein.vim.git ${dein_dir}
  fi
}

ln_if_not_exist () {
  if [ ! -e "$2" ]; then
    ln -s "$1" "$2"
  fi
}

deploy_config () {
  mkdir -p ${HOME}/.config
  ln_if_not_exist ${ROOT}/.zshenv ${HOME}/
  ln_if_not_exist ${ROOT}/.config/zsh ${HOME}/.config/
  ln_if_not_exist ${ROOT}/.config/nvim ${HOME}/.config/
  ln_if_not_exist ${ROOT}/.config/git ${HOME}/.config/
}

install_zplug
install_dein
deploy_config
