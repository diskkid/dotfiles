#!/bin/bash

ROOT="$(cd $(dirname $0); pwd)"

mkdir -p ${HOME}/.config
ln -s ${ROOT}/.zshrc ${HOME}/
ln -s ${ROOT}/.hyper.js ${HOME}/
ln -s ${ROOT}/.config/nvim ${HOME}/.config/
ln -s ${ROOT}/.config/git ${HOME}/.config/
