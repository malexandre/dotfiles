#export WORKON_HOME=$HOME/.virtualenvs
#export PROJECT_HOME=$HOME/dev
#source /usr/local/bin/virtualenvwrapper.sh

export APPENGINE=/home/marc/google-cloud-sdk/bin/
source /home/marc/google-cloud-sdk/path.bash.inc
source /home/marc/google-cloud-sdk/completion.bash.inc

alias ..="cd .."
alias ls="ls --color=auto"
alias appengine-python="/home/marc/google_appengine/dev_appserver.py ."
alias hyde-old="/home/marc/git/hyde-old/hyde.py -g -s . -k"
alias aperam-osiris="rdesktop 10.7.3.210 -g 1800x940 -k fr -u calypso\\\\administrator -p Lyon2013-08"
alias bashrc="subl ~/.bashrc"
alias gitlog="git --no-pager log --decorate=short --oneline --max-count=15"
alias gitreflog="git --no-pager reflog --max-count=15"
alias gitrebase="touch __tmp; git add __tmp > /dev/null; git commit -am \"tmp\" > /dev/null; git rebase origin/master; githead; rm __tmp;"
alias githead="git reset HEAD^"
alias gae-test-all="gae-test -a --coverage-html server server"


export PATH=$PATH:$APPENGINE

fortune | ponysay

function psaux()
{
    ps aux | grep "$1" | grep -v grep
}

function promptGit()
{
	if [[ -d ./.git ]]; then
	    local change_waiting_commit=`if git status | grep -q "nothing to commit"; then  echo ""; else echo ">"; fi`
		local current_branch=`git rev-parse --symbolic-full-name --abbrev-ref HEAD`
		local commits_behind=`git rev-list --left-right $current_branch...origin/master | grep -c "^>"`
		local commits_ahead=`git rev-list --left-right $current_branch...origin/master | grep -c "^<"`
		echo " [$change_waiting_commit$current_branch|-$commits_behind|+$commits_ahead]"
	fi
}

function promptPerso
{
	local GRAD1=`tty|cut -d/ -f3`
	PS1="\[\033[01;34m\][\#@$GRAD1] \$(date +%H:%M:%S) \[\033[00m\]${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[01;34m\] \[\033[01;31m\]\w\[\033[1;33m\]\$(promptGit) \[\033[01;34m\]\$\[\033[00m\] "
}
promptPerso

reloadBashrc()
{
	source ~/.bashrc
}

