# Description

Adds a lot of useful command-line shortcuts to Bash shells using aliases and functions. Many of them are already disseminated through the whole Internet, so you may recognize them. This documentation assumes you're using bash as your login shell.

_Work in Progress_

# Installation

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/hernanmd/mydot/master/install.sh)"
source ~/.bashrc
source ~/.bash_functions
```

## Using a login shell?

Depending on your environment, you can run a "login shell" (.bash_profile "friendly", getty+/usr/bin/login, bash --login, iTerm OSX Terminal) or a "regular (non-login, normal interactive) shell" (.bashrc "friendly", xterm, tmux). To check your shell is a “login shell” type:

```bash
shopt login_shell
```

If the reply is off you are not running a login shell. Otherwise if you are using a login shell you need to source the .bashrc (as all aliases and functions are sourced in .bashrc) from .bash_profile as follows:  

```bash
echo "source ~/.bashrc
source ~/.bash_functions" >> ~/.bash_profile
```

# Usage

## Meta-information about these aliases

```bash
# How many aliases do we have?
calias

# Listing all aliases
alias

# List Git aliases
gitalias

# List defined function names
listfunctions

# To view all the defined functions
viewfunctions
```

# Troubleshooting

WiP


