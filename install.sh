#!/bin/bash

ROOT="$(cd $(dirname $0); pwd)"

if [ ! -e ${HOME}/.local/share/zplug ]; then
  git clone https://github.com/zplug/zplug ${HOME}/.local/share/zplug
fi

mkdir -p ${HOME}/.config
ln -s ${ROOT}/.zshrc ${HOME}/
ln -s ${ROOT}/.hyper.js ${HOME}/
ln -s ${ROOT}/.config/nvim ${HOME}/.config/
ln -s ${ROOT}/.config/git ${HOME}/.config/
