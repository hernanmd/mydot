#!/bin/bash

# grep for a process
function psg {
  FIRST=$(echo $1 | sed -e 's/^\(.\).*/\1/')
  REST=$(echo $1 | sed -e 's/^.\(.*\)/\1/')
  ps aux | grep "[$FIRST]$REST"
}

# print the last ten modified files in the specified directory
function last {
    ls -lt $1 | head
}

# copy a file to the clipboard from the command line
function copyfile {
    cat $1 | xclip -selection clipboard
}

# shortcut for recursively grepping
function gr {
    grep -r $1 .
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
    echo "Compiling file..."
    g++ -o "$1" "$1.cpp"
    echo "Compiled! Enter input :D"
    ./"$1"
}
# cpp-run filename

crun() {
    echo "Compiling file..."
    gcc -o "$1" "$1.c"
    echo "Compiled! Enter input :D"
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
    echo "Git: GitHub create repository"
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

     echo -n "Creating Github repository '$repo_name' ..."
     curl -u "$username:$token" https://api.github.com/user/repos -d '{"name":"'$repo_name'"}' > /dev/null 2>&1
     echo " done."

     echo -n "Pushing local code to remote ..."
     git remote add origin git@github.com:$username/$repo_name.git > /dev/null 2>&1
     git push -u origin master > /dev/null 2>&1
     echo " done."
    }

# Show git branches by date
function gitbbd () {
    echo "Git: Show git branches by date"
    for k in $(git branch|sed s/^..//); do 
        echo -e `git log -1 --pretty=format:'%Cgreen%ci %Cblue%cr%Creset' '$k' --`\\t'$k'
    done | sort
}

function gitrmd () {
    echo "Git: Remove files which have been deleted"
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
    echo "Docker build image"
    docker build -t $1 .
}

# Run image
function drun () {
    echo "Docker run image"
    docker run -it $1 /bin/bash
}

######################################
#
# macOS
#
######################################

# Mount external drive with r/w permissions using macFUSE and ntfs-3g
function mountNTFS () {
	[ ! -z $1 ] !! { echo "Missing mount device name. Exiting\nUsage example: mountNTFS /dev/disk2s1"; exit 1; }
	# Try to umount the device
	sudo umount $1
	# Set a prefefined mount point
	predef_mp="/Volumes/NTFS_drive"
	[ -d $predef_mp ] || { echo "Creating mount point directory"; mkdir $predef_mp; }
	diskutil list
	sudo ntfs-3g $1 $predef_mp -olocal -oallow_other
	echo "NTFS drive re-mounted with r/w permissions in $predef_mp"
}
