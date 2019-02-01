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

install_nodenv () {
  local nodenv_dir=${HOME}/.local/share/nodenv
  if [ ! -e ${nodenv_dir} ]; then
    git clone https://github.com/nodenv/nodenv.git ${nodenv_dir}
  fi
}

install_node_build () {
  local plugins_dir=${HOME}/.local/share/nodenv/plugins
  mkdir -p $plugins_dir
  local node_build_dir=${plugins_dir}/node-build
  if [ ! -e ${node_build_dir} ]; then
    git clone https://github.com/nodenv/node-build.git ${node_build_dir}
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
install_nodenv
install_node_build
deploy_config
