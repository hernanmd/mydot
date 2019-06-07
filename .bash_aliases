# Aliases

# general shortcuts
alias c='cd '
alias cd..='cd ..'
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias mkdir='mkdir -pv'
alias mount='mount | column -t'
alias j='jobs -l'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'
alias bashrc='nano ~/.bash_profile'
alias less='less -FSRX'
alias tarx="tar xzvf"
alias tarc="tar czvf"
alias ff='find . -type f -iname'
alias f30min='echo "List files changed 30 min ago"; find . -cmin 30'
alias f1Mbig='echo "List files bigger than 1 Mbyte"; find . -size +1024 -ls'
alias f20Mbig='find . -size +20000k -exec du -h {} \;'
alias d0b='echo "Delete empty files"; find . -type f -size 0k -exec rm {} \;'
alias d0d='echo "Delete empty directories"; find -depth -type d -empty -exec rmdir {} \;'

# Text files
alias ftext='echo "Find text in files"; grep -ir $1 *"
alias pline='echo "Print line number"; sed -n "$1p"'
alias def='echo "Delete empty lines from file"; sed -i "^$/ {N; /^n$/D;}"'
alias dlsw='echo "Delete lines starting with"; grep -v "^$1"'

# Confirmation
alias mv='mv -i'
alias rm='rm -i'
alias ln='ln -i'

# listing files
alias l='ls -al'
# All entries + Colorize + Use Kb/Mb/Gb + Long format
alias ll='ls -aGhFl'
# List most recently modified first
alias ltr='ls -ltr'
alias lth='l -t | head'
alias lh='ls -Shl | less'
alias p='ls -1'

alias tf='tailf -n 100'
alias duss='du -s * | sort -g'

# Midgnight Commander
[[ -f '. /usr/libexec/mc/mc-wrapper.sh' ]] && { alias mc='. /usr/libexec/mc/mc-wrapper.sh'; }

alias path='echo $PATH | tr : \\n'
alias psx='ps awwfux | less -S'
alias vi='vim'

# grep for a process
function psg {
  FIRST=$(echo $1 | sed -e 's/^\(.\).*/\1/')
  REST=$(echo $1 | sed -e 's/^.\(.*\)/\1/')
  ps aux | grep "[$FIRST]$REST"
}

# Debian style apache control
alias htreload='/etc/init.d/apache2 reload'
alias htrestart='/etc/init.d/apache2 restart'
alias htstop='/etc/init.d/apache2 stop'

alias cycle_passenger='touch tmp/restart.txt'

# top level folder shortcuts
alias src='cd ~/src'

alias h?="history | grep -i "
alias h="history"
alias h1="history 10"
alias h2="history 20"
alias h3="history 30"

# Free and Used
alias meminfo="free -m -l -t"

# Get top process eating memory
alias psmem="ps auxf | sort -nr -k 4"
alias psmem10="ps auxf | sort -nr -k 4 | head -10"

# Get top process eating cpu
alias pscpu="ps auxf | sort -nr -k 3"
alias pscpu10="ps auxf | sort -nr -k 3 | head -10"

# Get server cpu info
alias cpuinfo="lscpu"

# older system use /proc/cpuinfo
#alias cpuinfo="less /proc/cpuinfo"

# Get GPU ram on desktop / laptop
alias gpumeminfo="grep -i --color memory /var/log/Xorg.0.log"

# Gives you what is using the most space. Both directories and files. Varies on current directory
alias most='du -hsx * | sort -rh | head -10'

# Git commands
alias gs="git status"
alias gl="git log"
alias ga="git add"
alias gaa="git add -A"
alias gc="git commit -m"
alias gp="git push"
# View all branches
alias gitab="git branch -av"
# Diff master
alias gitdiffm="git diff master origin/master"
# Git ignore file permissions
alias gitiperms="git config core.fileMode false"
# View Git alias
alias gitalias="alias | grep git"
# Remove files which have been deleted
# alias gitrmd="git rm $(git ls-files --deleted)"
# Better log
alias gitclog="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Cblue - %cn %Creset' --abbrev-commit --date=relative"
# Git diff last two commits
alias gitdifl2="echo 'Diff last 2 commits'; git diff HEAD^ HEAD"
# Git fetch all remote branches
alias gitbrall="echo 'Fetch all remote branches'; git branch -r | awk -F'/' '{print \"git fetch \"$1,$2}' | xargs -I {} sh -c {}"
# Git log
alias gitglog="git log -10 --graph --date-order -C -M --pretty=format:'%C(yellow)%h%C(reset) - %C(bold green)%ad%C(reset) - %C(dim yellow)%an%C(reset) %C(bold red)>%C(reset) %C(white)%s%C(reset) %C(bold red)%d%C(reset) ' --abbrev-commit --date=short"
# Git lines per contribution
alias gitlpc="git ls-files | xargs -n1 git blame --line-porcelain | sed -n 's/^author //p' | sort -f | uniq -ic | sort -nr"
alias gitl="git log --stat"
# Show git branches by date
# ToDo: Find how to escape $k in the following alias
# alias gitbbd="for k in `git branch|sed s/^..//`;do echo -e `git log -1 --pretty=format:'%Cgreen%ci %Cblue%cr%Creset' '$k' --`\\t'$k';done|sort"
# Show git branches sorted by last commit date
alias gitbsbd="git for-each-ref --sort=-committerdate refs/heads/"
# Show number of commits
alias gitcc="git log --pretty=oneline | wc -l"
# Open gitk UI
alias gk="gitk --all"

# Hub commands https://github.com/github/hub
alias hubhelp="open https://hub.github.com"
# Hub aliases
alias hubalias="alias | grep hub"
# Browse my issues
alias iss="hub browse issues"
# List the URLs of at most 20 PRs based on "develop" branch:
alias prlist="hub pr list -L 20 -b develop --format='%t [%H] | %U%n'"
# Create a GitHub release with notes from a file and copy the URL to clipboard:
alias gh-release-notes="hub release create -c -F release-notes.txt v2.3.0"

# List defined shell functions
alias listfunctions="declare -f"
alias viewfunctions="declare -F | less"

# Colorize the grep command output for ease of use (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'
# Do not wait interval 1 second, go fast #
alias fastping='ping -c 100 -s.2'

# Programming
alias gcc='gcc-6'
alias g++='g++-6'
alias python='python3'
alias pip='pip3'
alias pip_apt_install='sudo apt install python3-pip'
alias pip_upgrade='pip install --upgrade pip'
alias pip_req_install='pip install -r requirements.txt'
alias colcountt='awk -F"\t" "{print NF; exit}"'
alias colcountc='awk -F"," "{print NF; exit}"'

# Nano aliases
alias nano='nano -\$cwS'
alias cfgnano='https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh -O- | sh'

# Admin
alias usergadd='usermod -a -G'

# Install latest Pharo
alias ilpharo='wget -O- get.pharo.org | bash -'
alias runpharo='./pharo-ui Pharo.image &'

# Docker aliases
alias de="env | grep DOCKER_"
# Build image
alias dbuild="docker build -t $1 ."
# Run image
alias drun="docker run -it $1 /bin/bash"
# Remove all images
alias drall='echo "Remove all images"; docker rmi $(docker images -qf "dangling=true")'
alias dkar='echo "Kill containers and remove them"; docker rm $(docker kill $(docker ps -aq))'
alias drsc='echo "Remove stopped containers"; docker container prune'
alias dinfo='docker info'
alias dinspect='docker inspect'
alias drcont='echo "Start container"; docker start'

# Tmux aliases
alias tmxpinstall="pip install --user tmuxp"
alias tmxpload="tmuxp load .tmuxp.yaml"

# BSD specific aliases
alias l.='ls -GFd .*'
alias ll='ls -laGF'
alias ls='ls -la | grep "^d" && ls -la | grep -v "^d"'
alias lsd='ls -aF -d */'
alias rmdir='trash'

# Mount external drive on macOS
alias med="sudo /usr/local/bin/ntfs-3g $1 /Volumes/NTFS -olocal -oallow_other"
