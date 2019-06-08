#!/bin/bash

ROOT="$(cd $(dirname $0); pwd)"

install_latest() {
  local src_url="$1"
  local dest_dir="$2"

  if [[ -e "$dest_dir" ]]; then
    cd $dest_dir
    git pull
  else
    git clone "$src_url" "$dest_dir"
  fi
}

install_zplug () {
  install_latest \
    https://github.com/zplug/zplug \
    ${HOME}/.local/share/zplug
}

install_dein () {
  install_latest \
    https://github.com/Shougo/dein.vim.git \
    ${HOME}/.local/share/dein/repos/github.com/Shougo/dein.vim
}

install_rbenv () {
  install_latest \
    https://github.com/rbenv/rbenv.git \
    ${HOME}/.local/share/rbenv
}

install_ruby_build () {
  install_latest \
    https://github.com/rbenv/ruby-build.git \
    ${HOME}/.local/share/rbenv/plugins/ruby-build
}

install_nodenv () {
  install_latest \
    https://github.com/nodenv/nodenv.git \
    ${HOME}/.local/share/nodenv
}

install_node_build () {
  install_latest \
    https://github.com/nodenv/node-build.git \
    ${HOME}/.local/share/nodenv/plugins/node-build
}

install_jetbrains_npm () {
  install_latest \
    https://github.com/nodenv/jetbrains-npm.git \
    ${HOME}/.local/share/nodenv/lib/node_modules/npm
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
  mkdir -p ${HOME}/.config/Code/User
  ln_if_not_exist ${ROOT}/.config/Code/User/settings.json ${HOME}/.config/Code/User/settings.json
}

install_zplug
install_dein
install_rbenv
install_ruby_build
install_nodenv
install_node_build
install_jetbrains_npm
deploy_config
