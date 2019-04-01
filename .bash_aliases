# Aliases

# general shortcuts
alias c='cd '
alias mkdir='mkdir -pv'
alias mount='mount | column -t'
alias j='jobs -l'
alias now='date +"%T"'
alias nowtime=now
alias nowdate='date +"%d-%m-%Y"'
alias bashrc='nano ~/.bash_profile'

# Confirmation
alias mv='mv -i'
alias rm='rm -i'
alias ln='ln -i'

# listing files
alias l='ls -al'
alias ltr='ls -ltr'
alias lth='l -t | head'
alias lh='ls -Shl | less'
alias l.='ls -d .* --color=auto'
alias ll='ls -la --color=auto'
alias ls='ls -hla --color=auto --group-directories-first'
alias lsd='ls -aF --color=auto -d */'
alias tf='tailf -n 100'

alias duss='du -s * | sort -g'
alias mc='. /usr/libexec/mc/mc-wrapper.sh'
alias p='ls -1'
alias path='echo $PATH | tr : \\n'
alias psx='ps awwfux | less -S'
alias vi='vim'
alias which='alias | /usr/bin/which --tty-only --read-alias --show-dot --show-tilde'

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

alias h?="history | grep "
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

# Grabs the disk usage in the current directory
alias usage='du -ch | grep total'

# Gets the total disk usage on your machine
alias totalusage='df -hl --total | grep total'

# Shows the individual partition usages without the temporary memory values
alias partusage='df -hlT --exclude-type=tmpfs --exclude-type=devtmpfs'

# Gives you what is using the most space. Both directories and files. Varies on current directory
alias most='du -hsx * | sort -rh | head -10'

# Git commands
alias gs="git status"
alias gl="git log"
alias ga="git add"
alias gaa="git add -A"
alias gc="git commit -m"
# View all branches
alias gitab="git branches -av"
# Diff master
alias gitdiffm="git diff master origin/master"
# Git ignore file permissions
alias gitiperms="git config core.fileMode false"
# View Git alias
alias gitalias="alias | grep ^g | grep git"

# Colorize the grep command output for ease of use (good for log files)
alias grep='grep --color=auto'
alias egrep='egrep --color=auto'
alias fgrep='fgrep --color=auto'

# Stop after sending count ECHO_REQUEST packets #
alias ping='ping -c 5'
# Do not wait interval 1 second, go fast #
alias fastping='ping -c 100 -s.2'

# Show open ports
alias ports='netstat -tulanp'

# Programming
alias gcc='gcc-6'
alias g++='g++-6'
alias tar='gtar'
alias python='python3'
alias pip='pip3'
alias colcountt='awk -F"\t" "{print NF; exit}"'
alias colcountc='awk -F"," "{print NF; exit}"'

# Nano aliases
alias nano='nano -\$cwS'
