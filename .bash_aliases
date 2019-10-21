###################################
#
# Meta aliases
#
###################################

alias lalias='alias | less'
alias galias='alias | grep'
alias ealias='nano ~/.bash_aliases'
alias calias='alias | wc -l'
alias upalias='printf "Update aliases\n"; sh -c "$(curl -fsSL https://raw.githubusercontent.com/hernanmd/mydot/master/install.sh)"'

###################################
#
# General shortcuts
#
###################################

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
alias f30min='printf "List files changed 30 min ago\n"; find . -cmin 30'
alias f1Mbig='printf "List files bigger than 1 Mbyte\n"; find . -size +1024 -ls'
alias f20Mbig='find . -size +20000k -exec du -h {} \;'
alias ftop10var='printf "Find top 10 largest files in /var directory\n";tree -ihafF /var | tr "[]" " "| sort -k1hr|head -10'
alias d0b='printf "Delete empty files\n"; find . -type f -size 0k -exec rm {} \;'
alias d0d='printf "Delete empty directories\n"; find -depth -type d -empty -exec rmdir {} \;'
alias path='echo $PATH | tr : \\n'
alias vi='vim'
# Confirmation
alias mv='mv -i'
alias rm='rm -i'
alias ln='ln -i'
# List defined shell functions
alias listfunctions="declare -f"
alias viewfunctions="declare -F | less"
# Midgnight Commander
[[ -f '. /usr/libexec/mc/mc-wrapper.sh' ]] && { alias mc='. /usr/libexec/mc/mc-wrapper.sh'; }

###################################
#
# Text files aliases
#
###################################

alias ftext='echo "Find text in files"; grep -ir $1 *'
alias pline='echo "Print line number"; sed -n "$1p"'
alias def='echo "Delete empty lines from file"; sed -i "^$/ {N; /^n$/D;}"'
alias dlsw='echo "Delete lines starting with"; grep -v "^$1"'
alias tf='tailf -n 100'
# Colorize the grep command output for ease of use (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

###################################
#
# History aliases
#
###################################

alias h?="history | grep -i "
alias h="history"
alias h1="history 10"
alias h2="history 20"
alias h3="history 30"
alias top10histo="sort ~/.bash_history | uniq -c | sort -n | tail -n 10"

###################################
#
# Listing aliases
#
###################################

alias l='ls -al'
# All entries + Colorize + Use Kb/Mb/Gb + Long format
alias ll='ls -aGhFl'
alias lh='ls -Shl | less'
alias p='ls -1'

###################################
#
# Networking aliases
#
###################################

# Admin
alias usergadd='usermod -a -G'
# Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'
# Do not wait interval 1 second, go fast #
alias fastping='ping -c 100 -s.2'
alias randpass='printf "Generate a random password 14 characters long\n"; tr -c -d "a-zA-Z0-9" </dev/urandom | dd bs=14 count=1 2>/dev/null;echo'
alias genhosts='printf "Generate /etc/hosts contents\n"; echo "$(ip addr show dev $(ip r | grep -oP "default.*dev \K\S*") | grep -oP "(?<=inet )[^/]*(?=/)") $(hostname -f) $(hostname -s)"'
alias upips='printf "Scan whole specific network for active online ips\n"; nmap -n -sn 192.168.1.0/24 -oG - | awk "/Up$/{print $2}"'
alias iptlistnat='iptables -t nat --list'
alias iptlist='iptables -L -v'
alias iptbackup='/sbin/iptables-save > /root/iptables-works-$(date +%F)'

###################################
#
# Processes aliases
#
###################################

# Free and Used
alias meminfo="free -m -l -t"
# Get top process eating memory
alias psmem="ps auxf | sort -nr -k 4"
alias psmem10="ps auxf | sort -nr -k 4 | head -10"
# Get top process eating cpu
alias pscpu="ps auxf | sort -nr -k 3"
alias pscpu10="ps auxf | sort -nr -k 3 | head -10"
# Get GPU ram on desktop / laptop
alias gpumeminfo="grep -i --color memory /var/log/Xorg.0.log"
# older system use /proc/cpuinfo
#alias cpuinfo="less /proc/cpuinfo"

###################################
#
# Disk & Partition aliases
#
###################################

alias duss='du -s * | sort -g'
# Gives you what is using the most space. Both directories and files. Varies on current directory
alias most='du -hsx * | sort -rh | head -10'
alias blktrsda='printf "traces of the i/o traffic on block devices\n"; blktrace -d /dev/sda -o - | blkparse -i -'

###################################
#
# Debian style apache control aliases
#
###################################

alias htreload='/etc/init.d/apache2 reload'
alias htrestart='/etc/init.d/apache2 restart'
alias htstop='/etc/init.d/apache2 stop'
alias apache_findroot='grep -e "^[[:blank:]]*DocumentRoot[[:blank:]]\S"'
alias cycle_passenger='touch tmp/restart.txt'

###################################
#
# Non-Debian style apache control aliases
#
###################################

alias httpdreload='/usr/sbin/apachectl -k graceful'
alias httpdtest='/usr/sbin/apachectl -t && /usr/sbin/apachectl -t -D DUMP_VHOSTS'
alias httpdcfgtest='apachectl configtest'
alias httpd_findroot='apache2ctl -V | grep SERVER_CONFIG_FILE'

###################################
#
# NGINX aliases
#
###################################

alias nginxreload='sudo /usr/local/nginx/sbin/nginx -s reload'
alias nginxtest='sudo /usr/local/nginx/sbin/nginx -t'

###################################
#
# lightttpd aliases
#
###################################

alias lightyload='/etc/init.d/lighttpd reload'
alias lightytest='/usr/sbin/lighttpd -f /etc/lighttpd/lighttpd.conf -t'

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
alias pacInstall="pacman -S"
alias pacInstall="pacman -U"

alias pacListInstalledPkgs="pacman -Qe"
alias pacListForeignPkgs="pacman -Qm"
alias pacListQuery="pacman -Ql"
alias pacListDeps="pactree"
alias pacListDirectDeps="pacman -Qi"
alias pacListChanges="paccheck --md5sum --quiet2"
alias pacListBySize="pacman -Qi | egrep '^(Name|Installed)' | cut -f2 -d':' | paste - - | column -t | sort -nk 2 | grep MiB"
alias pacListOrphans="sudo find /etc /usr /opt /var | LC_ALL=C pacman -Qqo - 2>&1 > /dev/null | cut -d ' ' -f 5-"

alias pacBrowse="pacman -Qq | fzf --preview 'pacman -Qil {}' --layout=reverse --bind 'enter:execute(pacman -Qil {} | less)'"
alias pacUninst="pacman -R"
alias pacTracefile="pacman -Qo"
alias pacWhichPkgProvides="pacman -Fy; pacman -Fs"
alias pacAliases="alias | grep ^pac"

###################################
#
# hub aliases
#
###################################
# Hub commands https://github.com/github/hub

alias hubhelp="open https://hub.github.com"
# Hub aliases
alias hubalias="alias | grep hub "
# Browse my issues
alias iss="hub browse issues"
# List the URLs of at most 20 PRs based on "develop" branch:
alias prlist="hub pr list -L 20 -b develop --format='%t [%H] | %U%n'"
# Create a GitHub release with notes from a file and copy the URL to clipboard:
alias gh-release-notes="hub release create -c -F release-notes.txt v2.3.0"

###################################
#
# Programming aliases
#
###################################

alias gcc='gcc-6'
alias g++='g++-6'
alias python='python3'
alias pip='pip3'
alias pip_apt_install='sudo apt install python3-pip'
alias pip_upgrade='pip install --upgrade pip'
alias pip_req_install='pip install -r requirements.txt'
alias colcountt='awk -F"\t" "{print NF; exit}"'
alias colcountc='awk -F"," "{print NF; exit}"'
alias ipharo='echo "Install latest Pharo"; wget -O- get.pharo.org | bash -'
alias rpharo='./pharo-ui Pharo.image &'
alias epharo='./pharo --headless Pharo.image eval'
# top level folder shortcuts
alias src='cd ~/src'

###################################
#
# Nano aliases
#
###################################

alias nano='nano -\$cwS'
alias nanonano='nano ~/.nanorc'
alias install_nano_syntax_hl='wget https://raw.githubusercontent.com/scopatz/nanorc/master/install.sh -O- | sh'

###################################
#
# Docker aliases
#
###################################

alias dkalias='alias | grep ^dk'
alias dke="env | grep DOCKER_"
alias dkpsa="docker ps -aq"
alias dkrmi='docker rmi'
alias dkimgs='docker images'
alias dkrall='echo "Remove all images"; docker rmi $(docker images -qf "dangling=true")'
alias dkar='echo "Kill containers and remove them"; docker rm $(docker kill $(docker ps -aq))'
alias dkrsc='echo "Remove stopped containers"; docker container prune'
alias dkinfo='docker info'
alias dkinspect='docker inspect'
alias dkrcont='echo "Start container"; docker start'
alias dksysshow='systemctl show docker'
alias dksyslog='journalctl -u docker'

###################################
#
# Tmux aliases
#
###################################

alias tmxpinstall="pip install --user tmuxp"
alias tmxpload="tmuxp load .tmuxp.yaml"
alias etmuxconf="nano ~/.tmux.conf"
alias vtmuxconf="bat ~/.tmux.conf"
# Attaches tmux to the last session; creates a new session if none exists.
alias t='tmux attach || tmux new-session'
# Attaches tmux to a session (example: ta portal)
alias ta='tmux attach -t'
# Creates a new session
alias tn='tmux new-session'
# Lists all ongoing sessions
alias tl='tmux list-sessions'

###################################
#
# SSH aliases
#
###################################
# Do not create ssh alias, instead use ~/.ssh/config OpenSSH SSH client configuration files.
#Host server10
#  Hostname 1.2.3.4
#  IdentityFile ~/backups/.ssh/id_dsa
#  user foobar
#  Port 30000
#  ForwardX11Trusted yes
#  TCPKeepAlive yes


