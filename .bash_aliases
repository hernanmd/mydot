# Aliases
alias lalias='alias | less'
alias galias='alias | grep'

# General shortcuts
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
alias ftext='echo "Find text in files"; grep -ir $1 *'
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
alias vi='vim'

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

###################################
#
# Git commands
#
###################################

alias gs="git status"
alias gf="git fetch"
# Git fetch all remote branches
alias gitbrall="echo 'Fetch all remote branches'; git branch -r | awk -F'/' '{print \"git fetch \"$1,$2}' | xargs -I {} sh -c {}"
alias ga="git add"
alias gaa="git add -A"
alias gc="git commit -m"
alias gp="git push"
# View all branches
alias gitab="git branch -av"
# Git ignore file permissions
alias gitiperms="git config core.fileMode false"
# View Git alias
alias gitalias="alias | grep git"
# Get the original URL
alias giturl="git remote get-url origin"
# Get remote information
alias gitrinfo="git remote show origin"

###################################
#
# Git log aliases
#
###################################

alias gl="git log"
# Diff master
alias gitlog="git diff origin/master"
# Git diff last two commits
alias gitdifl2="echo 'Diff last 2 commits'; git diff HEAD^ HEAD"
# Git log
alias gitglog="git log -10 --graph --date-order -C -M --pretty=format:'%C(yellow)%h%C(reset) - %C(bold green)%ad%C(reset) - %C(dim yellow)%an%C(reset) %C(bold red)>%C(reset) %C(white)%s%C(reset) %C(bold red)%d%C(reset) ' --abbrev-commit --date=short"
# Git lines per contribution
alias gitlpc="git ls-files | xargs -n1 git blame --line-porcelain | sed -n 's/^author //p' | sort -f | uniq -ic | sort -nr"

alias gitl="git log --stat"
# Show git branches sorted by last commit date
alias gitbsbd="git for-each-ref --sort=-committerdate refs/heads/"
# Show number of commits
alias gitcc="git log --pretty=oneline | wc -l"
# Open gitk UI
alias gk="gitk --all"

###################################
#
# pacman aliases
#
###################################
# https://wiki.archlinux.org/index.php/Pacman/Tips_and_tricks#Listing_packages
alias pacsearch="pacman -Ss"
alias pacinstall="pacman -S"
alias pacinstall="pacman -U"

alias pacListInstalledPkgs="pacman -Qe"
alias pacListForeignPkgs="pacman -Qm"
alias pacListQuery="pacman -Ql"
alias pacListDeps="pactree"
alias pacListDirectDeps="pacman -Qi"
alias pacListChanges="paccheck --md5sum --quiet2"
alias pacBrowse="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"

alias pacListOrphans="sudo find /etc /usr /opt /var | LC_ALL=C pacman -Qqo - 2>&1 > /dev/null | cut -d ' ' -f 5-"

alias pacUninst="pacman -R"
alias pactracefile="pacman -Qo"
alias pacwhichpkgprovides="pacman -Fy; pacman -Fs"
alias pacAliases="alias | grep ^pac"

###################################
#
# hub aliases
#
###################################
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
alias ipharo='wget -O- get.pharo.org | bash -'
alias rpharo='./pharo-ui Pharo.image &'
alias epharo='./pharo --headless Pharo.image eval'

# Docker aliases
alias de="env | grep DOCKER_"

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


# GNU specific aliases
alias l.='ls -d .* --color=auto'
alias ll='ls -la --color=auto'
alias ls='ls -hla --color=auto --group-directories-first'
alias lsd='ls -aF --color=auto -d */'

# Show open ports
alias ports='netstat -tulanp'

# Get server cpu info
alias cpuinfo="lscpu"
# Get top process eating cpu
alias psx='ps awwfux | less -S'
alias pscpu="ps auxf | sort -nr -k 3"
alias pscpu10="ps auxf | sort -nr -k 3 | head -10"

# Gets the total disk usage on your machine
alias totalusage='df -hl --total | grep total'
# Grabs the disk usage in the current directory
alias usage='du -ch | grep total'

# Shows the individual partition usages without the temporary memory values
alias partusage='df -hlT --exclude-type=tmpfs --exclude-type=devtmpfs'

