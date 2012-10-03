#!/bin/bash

# Folder in home where this stuff is located (normally .bin)
ROOT=~/.bin


PATH=$PATH:$ROOT

# Loading colors and aliases
test -e $ROOT/.bin/.bash_colors  && . $ROOT/.bin/.bash_colors
test -e $ROOT/.bin/.bash_aliases && . $ROOT/.bin/.bash_aliases

# Host-specific options (server color, specific aliases etc)
test -e $ROOT/.hostinfo && . $ROOT/.hostinfo


# Check if ~/.vim folder exists. If don't - copy ours
[ -d ~/.vim ] || cp -r $ROOT/.vim ~/.vim

# Same for ~/.vimmrc. We do ln instead of copy in order to ease updates with git pull
[ -f ~/.vimrc ] || ln $ROOT/.vimrc ~/.vimrc


# get git status
function parse_git_status {
    # clear git variables
    GIT_BRANCH=
    GIT_DIRTY=
    GIT_DIR=

    # exit if no git found in system
    local GIT_BIN=$(which git 2>/dev/null)
    [[ -z $GIT_BIN ]] && return

    # check we are in git repo
    local CUR_DIR=$PWD
    while [ ! -d ${CUR_DIR}/.git ] && [ ! $CUR_DIR = "/" ]; do CUR_DIR=${CUR_DIR%/*}; done
    [[ ! -d ${CUR_DIR}/.git ]] && return

    # 'git repo for dotfiles' fix: show git status only in home dir and other git repos
    [[ $CUR_DIR == $HOME ]] && [[ $PWD != $HOME ]] && return

    # get git branch
    GIT_BRANCH=$($GIT_BIN symbolic-ref HEAD 2>/dev/null)
    [[ -z $GIT_BRANCH ]] && return
    GIT_BRANCH=${GIT_BRANCH#refs/heads/}

    # get git status
    local GIT_STATUS=$($GIT_BIN status --porcelain 2>/dev/null)
    [[ -n $GIT_STATUS ]] && GIT_DIRTY=true

    GIT_DIR=${CUR_DIR##*/}
}

function prompt_command {

  if [ `id -u` == "0" ]; then
    mUSER="\[${Red}\]\u\[\e[0m\]"
  else
    mUSER="\[${Green}\]\u\[${Color_Off}\]"
  fi

  if [ "$SIMPLE_PROMPT" == 'yes' ]; then
    PS1='`date "+%d.%m %H:%M:%S"`|${debian_chroot:+($debian_chroot)}'${mUSER}"@\[${HOST_COLOR:-$BWhite}\]\h\[${Green}\]:\[${Color_Off}\]"${PWD}"\[${BBlue}\]\$\[${Color_Off}\] "
    return 
  fi;

  local PWDNAME=$PWD

  # beautify working firectory name
  if [ $HOME == $PWD ]; then
    DIR="~"
  elif [ $HOME ==  ${PWD:0:${#HOME}} ]; then
    DIR="~${PWD:${#HOME}}"
  else
    DIR=$PWD
  fi

  # parse git status and get git variables
  parse_git_status

  # build git status for prompt
  if [ ! -z $GIT_BRANCH ]; then
      if [ $GIT_BRANCH == "master" ]; then
         COLOR=${BRed};
      else
         COLOR=${BGreen};
      fi

      if [ ! -z $GIT_DIRTY ]; then
        BRANCH="\[${BYellow}\][${GIT_BRANCH}]\[${Color_Off}\]"
      else
        BRANCH="[${GIT_BRANCH}]"
      fi

      if [ "x${GIT_DIR}" == "x" ]; then
        PS1_GIT=${DIR}
       else
        repl=${DIR%$GIT_DIR*}'\['${COLOR}'\]'${GIT_DIR}${BRANCH}'\['${Color_Off}'\]'${DIR##*$GIT_DIR}
        PS1_GIT=${repl} #`echo "${DIR}" | sed "s|/${GIT_DIR}|/${repl}|"`
      fi
  else
  	PS1_GIT='\w'
  fi

PS1="\[${DATE_COLOR}\]`date '+%d.%m %H:%M:%S'`\[${Color_Off}\]|${debian_chroot:+($debian_chroot)}${mUSER}@\[${HOST_COLOR:-$BWhite}\]\h\[${Green}\]:\[${Color_Off}\]"${PS1_GIT}"\[${BBlue}\]\$\[${Color_Off}\] "

}

PROMPT_COMMAND=prompt_command
