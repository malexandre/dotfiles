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
	    local change_waiting_commit=`if git status | grep -q "nothing to commit (working directory clean)"; then  echo ""; else echo ">"; fi`
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

function draft()
{
    local editor=""
    local title=""
    while test $# -gt 0; do
        case "$1" in
            -c)
                editor="$2"
                shift
                shift
                ;;
            *)
                if [[ "$title" = "" ]]; then
                    title="$1"
                fi
                shift
                ;;
        esac
    done

    if [[ -f ./_config.yml ]]; then
        if [[ ! -d ./_drafts ]]; then
            mkdir _drafts
        fi

        if [[ "$title" = "" ]]; then
            title="untitled-`date +%s`.markdown"
        elif [[ "$title" != *.markdown && "$title" != *.md ]]; then
            title="$title.markdown"
        fi

        title=`echo "$title" | sed -e 's/['"'"' _]/-/g'`
        title=`echo "$title" | sed -e 's/[éèê]/e/g'`
        title=`echo "$title" | sed -e 's/à/a/g'`
        title=`echo "$title" | sed -e 's/ï/i/g'`
        title=`echo "$title" | sed -e 's/û/u/g'`
        title=`echo "$title" | sed -e 's/ô/o/g'`
        title=`echo "$title" | sed -e 's/[^0-9a-zA-Z.-]//g'`

        if [[ -f ./_drafts/"$title" ]]; then
            echo "The file '_drafts/$title' already exists, please choose a different name"
            return 1
        fi

        echo -e "\
---\n\
layout: post\n\
title: $title\n\
---\n\
Content goes here\n" > _drafts/"$title"

        if [[ "$editor" != "" ]]; then
            "$editor" _drafts/"$title"
        else
            echo "File available at _drafts/$title"
        fi
    else
        echo "Not in a Jekyll folder"
    fi
}


function publish()
{
    if [[ -f ./_config.yml ]]; then
        if [[ "$1" = "" ]]; then
            echo "No file to publish in argument"
            return 1
        fi

        if [[ ! -f ./"$1" ]]; then
            echo "'$1' not found"
            return 1
        fi

        if [[ "test.md" =~ \.(md|markdown)$ ]]; then
            local currentDateYAML=`date +%Y-%m-%d\ %H:%M:%S`
            local currentDateJekyll=`date +%Y-%m-%d`
            local filename=$(basename $1)
            head -n 1 "$1" > "_posts/$currentDateJekyll-$filename"
            echo "date: $currentDateYAML" >> "_posts/$currentDateJekyll-$filename"
            tail -n +2 "$1" >> "_posts/$currentDateJekyll-$filename"
            rm -f "$1"
        else
            echo "'$1' is not a markdown file"
        fi
    else
        echo "Not in a Jekyll folder"
    fi
}
