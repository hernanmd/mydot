#!/bin/bash

function bakfwd () {
    printf "From .bash_functions: Create backup copy of file, adding suffix of the date of the file modification (NOT today's date)\n"    
    cp "$1"{,.$(date -r "$1" "+%y%m%d")}
}

function psg {
    printf "From .bash_functions: Grep for a process\n"
    FIRST=$(echo "$1" | sed -e 's/^\(.\).*/\1/')
    REST=$(echo "$1" | sed -e 's/^.\(.*\)/\1/')
    ps aux | grep "[$FIRST]$REST"
}

###################################
#
# Text files functions
#
###################################

function copyfile {
    printf "From .bash_functions: Copy a file to the clipboard from the command line\n"
    xclip -selection clipboard < "$1"
}

function last {
    printf "From .bash_functions: Print the last ten modified files in the specified directory\n"
    ls -lt "$1" | head
}

function ftext {
    printf "From .bash_functions: Find text in files\n"
    grep -ir "$1" ./*
}

function gr {
    printf "From .bash_functions: shortcut for recursively grepping\n"    
    grep -r "$1" .
}

function dlsw { 
    printf "Delete lines starting with...\n"
    grep -v "^$1"
}

function pline { 
    printf "Print line number..."
    sed -n "$1p"
}

###################################
#
# Navigation functions
#
###################################

function mkcdir ()
{
    printf "From .bash_functions: mkdir & cd\n"
    mkdir -p -- "$1" && cd -P -- "$1" || exit
}

########################################
#
# Programming: C and C++
#
########################################

# shortcut for compiling and running C++ programs
function g {
    filename="${1%.*}"
    g++ $filename.cpp -o $filename
    if [[ $? == 0 ]]; then
       ./$filename
    fi
}

cpprun() {
    printf "Compiling file...\n"
    g++ -o "$1" "$1.cpp"
    printf "Compiling file...\n"
    ./"$1"
}
# cpp-run filename

crun() {
    printf "Compiling file...\n"
    gcc -o "$1" "$1.c"
    printf "Compiling file...\n"
    ./"$1"
}

########################################
#
# Programming: Git
#
########################################

# Add git branch if its present to PS1
parse_git_branch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Pass the function to the color parser of the terminal to colorize the branch name.
if [ "$color_prompt" = yes ]; then
    if [[ ${EUID} == 0 ]] ; then
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\h\[\033[01;34m\] \W $(parse_git_branch)\$\[\033[00m\] '
    else
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\] \[\033[01;34m\]\w $(parse_git_branch)\$\[\033[00m\] '
    fi
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h \w \$ '
fi
unset color_prompt force_color_prompt


github_create() {
    printf "From .bash_functions: GitHub create repository\n"
    repo_name=$1
    dir_name=$(basename $(pwd))

    if [ "$repo_name" = "" ]; then
        echo "Repo name: hit enter to use '$dir_name' ?"
        read repo_name
    fi

    if [ "$repo_name" = "" ]; then
        repo_name=$dir_name
    fi

    username=`git config github.user`
    if [ "$username" = "" ]; then
        echo "Could not find username, run 'git config --global github.user <username>'"
        invalid_credentials=1
    fi

    token=`git config github.token`
    if [ "$token" = "" ]; then
        echo "Could not find token, run 'git config --global github.token <token>'"
        invalid_credentials=1
    fi

    if [ "$invalid_credentials" == "1" ]; then
        return 1
    fi

    printf "Creating Github repository '$repo_name' ..."
    curl -u "$username:$token" https://api.github.com/user/repos -d '{"name":"'$repo_name'"}' > /dev/null 2>&1
    printf " done.\n"

    printf "Pushing local code to remote ..."
    git remote add origin git@github.com:"$username"/"$repo_name".git > /dev/null 2>&1
    git push -u origin master > /dev/null 2>&1
    printf " done.\n"
}

# Show git branches by date
function gitbbd () {
    printf "From .bash_functions: Show git branches by date\n"
    for k in $(git branch|sed s/^..//); do 
        echo -e $(git log -1 --pretty=format:'%Cgreen%ci %Cblue%cr%Creset' "$k" --)\\t"$k"
    done | sort
}

function gitrmd () {
    printf "From .bash_functions: Remove files which have been deleted\n"
    git rm $(git ls-files --deleted)
}

# Better log
function gitclog () {
    git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Cblue - %cn %Creset' --abbrev-commit --date=relative
}

########################################
#
# DevOps: Docker
#
########################################

# Build image
function dbuild () {
    printf "From .bash_functions: Docker build image\n"
    docker build -t $1 .
}

# Run image
function drun () {
    printf "From .bash_functions: Docker run image\n"
    docker run -it $1 /bin/bash
}

######################################
#
# macOS
#
######################################

# Mount external drive with r/w permissions using macFUSE and ntfs-3g
function mountNTFS () {
	[ -n "$1" ] || { echo "Missing mount device name. Exiting\nUsage example: mountNTFS /dev/disk2s1"; exit 1; }
	# Try to umount the device
	umount "$1"
	# Set a prefefined mount point
	predef_mp="/Volumes/NTFS_drive"
	[ -d "$predef_mp" ] || { printf "Creating mount point directory\n"; mkdir "$predef_mp"; }
	diskutil list
	sudo ntfs-3g "$1" "$predef_mp" -olocal -oallow_other
	printf "NTFS drive re-mounted with r/w permissions in %s" "$predef_mp"
}

######################################
#
# Pacman
#
######################################

function pacRemoveOrphans () {
    pacman -Rns $(pacman -Qtdq)
}
