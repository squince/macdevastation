alias ll='ls -lhaFG'
alias vi='/Applications/MacVim.app/Contents/MacOS/Vim'
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
alias td='/usr/local/Cellar/todo-txt/2.9/bin/todo.sh'
alias tdl='clear; /usr/local/Cellar/todo-txt/2.9/bin/todo.sh ls'
alias todo='/usr/local/Cellar/todo-txt/2.9/bin/todo.sh'
alias ll='ls -lhaFG'
alias fixmysql='myisamchk --silent --force --fast --update-state /home/dataw/mysql/*/*.MYI'
alias gitching="git whatchanged | grep -A 4 commit | less"
alias ports="netstat -a | grep LISTEN"
alias listen="lsof -n -i4TCP:"
alias pairs="~/github/pair-stats/pair-stats"
alias gitbranches="git for-each-ref --format='%(committerdate) %09 %(authorname) %09 %(refname)' | sort -k5n -k2M -k3n -k4n"
alias gitgraph="git log --graph --oneline"
alias localmail="sudo python -m smtpd -n -c DebuggingServer localhost:25"

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

export PATH="/usr/local/share/npm/bin:/usr/local/bin:${PATH}"
export EDITOR=vim

# Git completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Setup hs* commands
HSPATH='/usr/local/share/hs'
if [ -d $HSPATH ]; then
  HSFILES=(`ls $HSPATH`)
  HSCOUNT=${#HSFILES[*]}
  for (( HSI=0 ; $HSI < $HSCOUNT ; HSI=$HSI+1 )); do
    HSFILE=${HSFILES[HSI]}
    HSFILE=${HSFILE:6}
    alias hs$HSFILE='hs '$HSFILE
  done
fi
unset HSPATH HSFILES HSCOUNT HSI HSFILE

set -o vi
source ~/.todo/todo_completion
complete -F _todo td
complete -F _todo todo

#source ~/.git-pairing-prompt.sh
#export PROMPT_COMMAND='__git_pairing_prompt; echo -ne "];${PWD##*/}"'
