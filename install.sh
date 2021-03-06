#!/bin/bash

readonly add_ss_msg="Adding platform aliases to system specific aliases file"

# Backup current aliases into bash_aliases.bck
backup_aliases() {
	[[ -f ~/.bash_aliases ]] && { printf "Backup current aliases file\n"; cp ~/.bash_aliases ~/.bash_aliases.bck; }
}

add_gnu_aliases() {
	printf "%s\n" "$add_ss_msg"
	cat mydot/.aliases_GNU >> ~/.ss_aliases
}

add_bsd_aliases() {
	printf "%s\n" "$add_ss_msg"
	cat mydot/.aliases_BSD >> ~/.ss_aliases
}

# Configure GNU (Linux) or BSD (macOS) specific aliases
setup_platform_aliases() {
	case $(echo "$OSTYPE" | tr '[:upper:]' '[:lower:]') in
	        linux*|msys*)
				add_gnu_aliases
				;;
	        mac*|darwin*)
				add_bsd_aliases
				;;
	        *)
				printf "Trying OS detection through uname...\n"
				case $(uname -s | tr '[:upper:]' '[:lower:]') in
					linux*|msys*)
						add_gnu_aliases
						;;
					mac*|darwin*)
						add_bsd_aliases
						;;
					*)
						echo "unknown OS: $OSTYPE: Some aliases will not be available"
						exit
						;;
				esac
				;;
	esac
}

launch_install() {
	printf "%sInfo: Setup aliases%s\n" "${YELLOW}" "${NORMAL}"
	./mydot/setup
}

source_files() {
	[[ -f ~/.bash_aliases ]] || printf "%sError: bash aliases not found%s\n" "${RED}" "${NORMAL}"
	source ~/.bash_aliases
	[[ -f ~/.bash_aliases ]] || printf "%sError: bash functions not found%s\n" "${RED}" "${NORMAL}"
	source ~/.bash_functions
	[[ -f ~/.bash_aliases ]] || printf "%sError: .bashrc not found%s\n" "${RED}" "${NORMAL}"
	source ~/.bashrc
}

main() {
	# Use colors, but only if connected to a terminal, and that terminal supports them.
	if command -v tput >/dev/null 2>&1; then
		ncolors=$(tput colors)
	fi
	if [ -t 1 ] && [ -n "$ncolors" ] && [ "$ncolors" -ge 8 ]; then
	  RED="$(tput setaf 1)"
	  GREEN="$(tput setaf 2)"
	  YELLOW="$(tput setaf 3)"
	  BLUE="$(tput setaf 4)"
	  BOLD="$(tput bold)"
	  NORMAL="$(tput sgr0)"
	else
	  RED=""
	  GREEN=""
	  YELLOW=""
	  BLUE=""
	  BOLD=""
	  NORMAL=""
	fi

	# Only enable exit-on-error after the non-critical colorization stuff,
	# which may fail on systems lacking tput or terminfo
	set -e

	# Prevent the cloned repository from having insecure permissions. Failing to do
	# so causes compinit() calls to fail with "command not found: compdef" errors
	# for users with insecure umasks (e.g., "002", allowing group writability). Note
	# that this will be ignored under Cygwin by default, as Windows ACLs take
	# precedence over umasks except for filesystems mounted with option "noacl".
	umask g-w,o-w

	printf "${YELLOW}Installing hernan's dotted files...${NORMAL}\n"
	type git >/dev/null 2>&1 || {
	  printf "%sError: git is not installed%s\n" "{$RED}" "{$NORMAL}"
	  exit 1
	}
	# The Windows (MSYS) Git is not compatible with normal use on cygwin
	if [ "$OSTYPE" = cygwin ]; then
		if git --version | grep msysgit > /dev/null; then
		  printf "%s Error: Windows/MSYS Git is not supported on Cygwin\n" "${RED}"
		  printf "%s Error: Make sure the Cygwin git package is installed and is first on the path.\n %s" "${RED}" "${NORMAL}"
		  exit 1
		fi
	fi
	env git clone --depth=1 https://github.com/hernanmd/mydot.git || {
		printf "%s Error: git clone of repository failed. %s\n" "${RED}" "${NORMAL}"
		exit 1
	}

	backup_aliases
	setup_platform_aliases
	launch_install
	# source_files

	printf "${GREEN}"
	echo 'mydot is now installed!'
	echo ''
	echo 'p.s. If you like this work star it at https://github.com/hernanmd/mydot'
	echo ''
	printf "${NORMAL}"
}

main
