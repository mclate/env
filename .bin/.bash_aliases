#!/bin/bash
# Global aliases

alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

export LS_OPTIONS="--color"
alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -l'
alias l='ls $LS_OPTIONS -Al'

alias m8='mtr 8.8.8.8'
alias p8='ping 8.8.8.8'
alias pw='pwgen 10'

# vim: set filetype=sh syntax=sh
