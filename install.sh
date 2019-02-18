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

install_rbenv () {
  local rbenv_dir=${HOME}/.local/share/rbenv
  if [ ! -e ${rbenv_dir} ]; then
    git clone https://github.com/rbenv/rbenv.git ${rbenv_dir}
  fi
}

install_ruby_build () {
  local plugins_dir=${HOME}/.local/share/rbenv/plugins
  mkdir -p $plugins_dir
  local ruby_build_dir=${plugins_dir}/ruby-build
  if [ ! -e ${ruby_build_dir} ]; then
    git clone https://github.com/rbenv/ruby-build.git ${ruby_build_dir}
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
  if [ -e "$2" ]; then
    echo "$2 already exists."
  else
    ln -s "$1" "$2"
  fi
}

deploy_config () {
  mkdir -p ${HOME}/.config
  ln_if_not_exist ${ROOT}/.zshenv ${HOME}/.zshenv
  ln_if_not_exist ${ROOT}/.config/zsh ${HOME}/.config/zsh
  ln_if_not_exist ${ROOT}/.config/nvim ${HOME}/.config/nvim
  ln_if_not_exist ${ROOT}/.config/git ${HOME}/.config/git
}

install_zplug
install_dein
install_rbenv
install_ruby_build
install_nodenv
install_node_build
deploy_config
