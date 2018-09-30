#!/bin/bash

set -e

# bootstrap a new system account with useful stuff


GIT_DIR="${HOME}/git"
BOOTSTRAP_DIR="${GIT_DIR}/bootstrap"


# make sure custom bashrc is sourced
grep CUSTOM_BASHRC ~/.bashrc >/dev/null
HAS_CUSTOM_BASHRC=$?
echo ${HAS_CUSTOM_BASHRC}

if [[ 1 -eq HAS_CUSTOM_BASHRC ]]; then
cat << 'EOF' >> ~/.bashrc
CUSTOM_BASHRC=~/.bashrc_custom
if [ -f ${CUSTOM_BASHRC} ]; then
  . ${CUSTOM_BASHRC}
fi
EOF


# get repo and install dotfiles
mkdir -p "${GIT_DIR}"
cd "${GIT_DIR}"
git clone https://github.com/chefkoch666/bootstrap.git


install_from_template() {
  DST="$HOME/.$1"
  TEMPLATE="dotfiles/$1"

  if [[ -e $DST ]]; then
    cmp "$DST" "$TEMPLATE" || vimdiff "$DST" "$TEMPLATE"
  else
    cp "$TEMPLATE" "$DST"
  fi
}


install_from_template bashrc_custom
install_from_template inputrc
install_from_template vimrc
install_from_template screenrc
#install_from_template gitconfig 
#install_from_template gitignore
