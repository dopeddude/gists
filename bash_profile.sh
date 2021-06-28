#!/usr/bin/env bash
# Author: Ashwini Kumar (kumarashwini@outlook.com)

# =================================
# Generic functions - Should be maintained so that they can go on the gist as is
# =================================

# set -e
# set -u

# shellcheck disable=SC2034

println() {
	# shellcheck disable=SC2154
	if [ "${DEBUG:=placeholder}" = 'y' ] || [ "${1}" != "DEBUG" ]; then
		printf "%b\\n" "$*"
	fi
}

errprintln() {
	printf "%b\\n" "$*" >&2
}

die() {
	errprintln "$*" && exit 1
}

starts_with() {
	local string="$1"
	local substring="$2"
	println "DEBUG" "inside starts_with ${string} and ${substring}"
	case "${string}" in
		"${substring}"*) println "DEBUG" "starts with path"; return 0;;
		*) println "DEBUG" "this is the default"; return 1;;
	esac
}

contains() {
	local string="$1"
	local substring="$2"
	println "DEBUG" "inside contains ${string} and ${substring}"
	case "${string}" in
		*"${substring}"*) println "DEBUG" "contains path"; return 0;;
		*) println "DEBUG" "this is the default"; return 1;;
	esac
}

ends_with() {
	local string="$1"
	local substring="$2"
	println "DEBUG" "inside ends_with ${string} and ${substring}"
	case "${string}" in
		*"${substring}") println "DEBUG" "ends with path"; return 0;;
		*) println "DEBUG" "this is the default"; return 1;;
	esac
}

vlc() {
	open -a "/Applications/VLC.app/" "$@"
}

json() {
	python -m json.tool
}

exec() {
	docker exec -it "${1}" bash -l
}

cgrep() {
	if [ "${1}" = '' ]; then
		extra_args="${1:-'(TODO|DEBUG) \(ashwkum4\)'}" # TODO not working - Need to debug
		extra_args="${1:-TODO}"
	else
		extra_args="$*"
	fi
	cmd="grep -Einr --exclude-dir=node_modules --exclude-dir=dist --exclude-dir=build --exclude-dir=vendor --include=\"*\" ${extra_args} *"
	printf "%b\\n" "${WHITE}${cmd}${NORMAL}"
	"${cmd}"
}

ccode() {
	code an-ui.code-workspace
}

s() {
	git status
}

dc() {
	git diff --cached "$@"
}

d() {
	git diff "$@"
}

# shellcheck disable=SC2120
a() {
	[ $# -eq 0 ] && git add . && return
	git add "$@"
}

cnv() {
	local m=''
	if [ "${1}" = "" ]; then
		local last_commit_message=$(git log -1 --pretty=%B)
		IFS= read -ei "${last_commit_message}" m
	else
		m=$@
	fi
	git commit --no-verify -m "$m"
}

c() {
	local m=''
	if [ "$1" == "" ]; then
		local last_commit_message=$(git log -1 --pretty=%B)
		IFS= read -ei "${last_commit_message}" m
	else
		m=$@
	fi
	git commit -m "$m"
}

p() {
	git push
}

acnvp() {
	a && cnv "$@" && p
}

# shellcheck disable=SC2120
acp() {
	a && c "$@" && p
}

acd() {
  if [ -d "${HOME}/go/src/github.com/dopeddude/${1}/${2}" ]; then
          cd "${HOME}/go/src/github.com/dopeddude/${1}/${2}"
  else
          errprintln "No such directory found!"
  fi
}

[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

for file in ~/bash_completion.d/*
do
	if [ -f ${file} ]; then
		source "$file"
	fi
done

for file in ${HOME}/go/src/github.com/dopeddude/gists/bash-completion/*
do
	if [ -f ${file} ]; then
		source "$file"
	fi
done

# Your company specific bash completions, ashwkum4 is my cisco id
for file in ${HOME}/go/src/github.com/dopeddude/gists/bash-completion/ashwkum4/*
do
	if [ -f ${file} ]; then
		source "$file"
	fi
done


BLACK=$(tput setaf 0)
RED=$(tput setaf 1)
GREEN=$(tput setaf 2)
YELLOW=$(tput setaf 3)
LIME_YELLOW=$(tput setaf 190)
POWDER_BLUE=$(tput setaf 153)
BLUE=$(tput setaf 4)
MAGENTA=$(tput setaf 5)
CYAN=$(tput setaf 6)
WHITE=$(tput setaf 7)
BRIGHT=$(tput bold)
NORMAL=$(tput sgr0)
BLINK=$(tput blink)
REVERSE=$(tput smso)
UNDERLINE=$(tput smul)

alias ll='ls -l'
alias l='ls -lA'
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# export HISTTIMEFORMAT="%h %d %H:%M:%S> "
HISTSIZE=10000
HISTCONTROL=ignoredups:erasedups
shopt -s histappend
# PROMPT_COMMAND="history -n; history -w; history -c; history -r; ${PROMPT_COMMAND}"
EDITOR=vim
# Love for vi, while using CLI
set -o vi
#set -o emacs

# export JAVA_HOME=$(/usr/libexec/java_home)

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#PATH="/usr/local/bin:${PATH}"
PATH="/usr/local/opt/make/libexec/gnubin:$PATH"

ulimit -n 1024

# For Photon Development
# export GOPATH="$HOME/go/src/bitbucket-eng-sjc1.cisco.com/an/photon_dev/docker/rootfs/go"
export GOPATH="$HOME/go"
# export GOBIN="$GOPATH/bin"
# export PATH="${GOBIN}:/usr/X11/bin:$PATH"

# Your company specific bash profile, ashwkum4 is my cisco id
# shellcheck disable=SC1090
# For Photon Development
# . "${HOME}/go/src/github.com/dopeddude/gists/ashwkum4_profile.sh"
# For Non Photon Development
. "${HOME}/go/src/github.com/dopeddude/gists/ashwkum4_profile.sh"

export PATH
PS1='\n${PWD#"${PWD%/*/*}/"} \$\n'
