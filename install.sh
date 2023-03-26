#!/bin/bash

fail () {
  echo "$@" >&2
    exit 1
}
SCRIPT=$0
SCRIPTDIR=$(dirname -- "$SCRIPT")
if ! [ "$SCRIPTDIR" == "$HOME/.vim" ]; then
  if [ -d "$HOME/.config/nvim" ]; then
    mv -- "$HOME/.config/nvim"{,.bak}
  fi
  echo "copying to $HOME/.config/nvim"
  cp -r -- $SCRIPTDIR $HOME/.config/nvim || fail "failed copy"
  exit $?
fi


