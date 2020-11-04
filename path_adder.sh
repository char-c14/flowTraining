#!/usr/bin/env bash

set -e
[ -n "$PYENV_DEBUG" ] && set -x

if [ -z "$PYENV_ROOT" ]; then
  PYENV_ROOT="${HOME}/.pyenv"
fi

colorize() {
  if [ -t 1 ]; then printf "\e[%sm%s\e[m" "$1" "$2"
  else echo -n "$2"
  fi
}

if ! command -v pyenv 1>/dev/null; then
  { echo
    colorize 1 "WARNING"
    echo ": seems you still have not added 'pyenv' to the load path."
    echo
  } >&2

  shell="${SHELL}"
  IFS='/'
  read -a strarr <<< "$shell"
  length=${#strarr[*]}
  shell=${strarr[$length-1]} 

  echo "Sh3ll is: ${shell}" >&1

  case "$shell" in
  bash )
    profile="~/.bashrc"
    ;;
  sh )
    profile="~/.profile"
    ;;
  zsh )
    profile="~/.zshrc"
    ;;
  ksh )
    profile="~/.profile"
    ;;
  fish )
    profile="~/.config/fish/config.fish"
    ;;
  * )
    profile="your profile"
    ;;
  esac

  echo "Profile is: ${profile}" >&1
  PROFILE=${HOME}/${profile#'~/'}
  echo "Expanded correct PROFILE is: ${PROFILE}" >&1

  case "$shell" in
    fish )
      echo "set -x PATH \"${PYENV_ROOT}/bin\" \$PATH" >> "$PROFILE"
      echo 'status --is-interactive; and . (pyenv init -|psub)' >> "$PROFILE"
      echo 'status --is-interactive; and . (pyenv virtualenv-init -|psub)' >> "$PROFILE"
      ;;
    * )
      echo "export PATH=\"${PYENV_ROOT}/bin:\$PATH\"" >> "$PROFILE"
      echo "eval \"\$(pyenv init -)\"" >> "$PROFILE"
      echo "eval \"\$(pyenv virtualenv-init -)\"" >> "$PROFILE"
      ;;
  esac
fi
