#!/bin/bash

ROOT="$(cd $(dirname $0); pwd)"

zplug_dir=${HOME}/.local/share/zplug
if [ ! -e ${zplug_dir} ]; then
  git clone https://github.com/zplug/zplug ${zplug_dir}
fi

dein_dir=${HOME}/.local/share/dein/repos/github.com/Shougo/dein.vim
if [ ! -e ${dein_dir} ]; then
  git clone https://github.com/Shougo/dein.vim.git ${dein_dir}
fi

mkdir -p ${HOME}/.config
ln -s ${ROOT}/.zshenv ${HOME}/
ln -s ${ROOT}/.config/zsh ${HOME}/.config/
ln -s ${ROOT}/.hyper.js ${HOME}/
ln -s ${ROOT}/.config/nvim ${HOME}/.config/
ln -s ${ROOT}/.config/git ${HOME}/.config/
