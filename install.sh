
# Configure GNU (Linux) or BSD (macOS) specific aliases
setupPlatformAliases () ��{
	case "$OSTYPE" in
	        linux*|msys*)
			echo "Adding GNU aliases to .bash_aliases"
�	                cat .aliases_GNU >> .bash_aliases
	                ;;
	        mac*|darwin*)
			echo "Adding BSD aliases to .bash_aliases"
			cat .aliases_BSD >> .bash_aliases
	                ;;
	        *)
	                echo "unknown OS: $OSTYPE: Some aliases will not be available"
	                exit 1
	                ;;
	esac
}

launch_install() {
	./mydot/setup
}

source_files() {
	[[ -f ~/.bash_aliases ]] || echo "Error: bash aliases not found"
	source ~/.bash_aliases
	[[ -f ~/.bash_aliases ]] || echo "Error: bash functions not found"
	source ~/.bash_functions
	[[ -f ~/.bash_aliases ]] || echo "bashrc not found"
	source ~/.bashrc
}

main() {
	# Use colors, but only if connected to a terminal, and that terminal supports them.
	if which tput >/dev/null 2>&1; then
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
	  printf "${RED}Error: git is not installed{$NORMAL}\n"
	  exit 1
	}
	# The Windows (MSYS) Git is not compatible with normal use on cygwin
	if [ "$OSTYPE" = cygwin ]; then
		if git --version | grep msysgit > /dev/null; then
		  echo "Error: Windows/MSYS Git is not supported on Cygwin"
		  echo "Error: Make sure the Cygwin git package is installed and is first on the path"
		  exit 1
		fi
	fi
	env git clone --depth=1 https://github.com/hernanmd/mydot.git || {
		printf "${RED}Error: git clone of repository failed.${NORMAL}\n"
		exit 1
	}

	setupPlatformAliases
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
