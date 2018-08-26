# ToDo.sh
alias td='/usr/local/Cellar/todo-txt/2.10/bin/todo.sh'
alias tdl='clear; /usr/local/Cellar/todo-txt/2.10/bin/todo.sh ls'
alias todo='/usr/local/Cellar/todo-txt/2.10/bin/todo.sh'

# Environment Stuff
alias ll='ls -lhaFG'
alias vi='/Applications/MacVim.app/Contents/MacOS/Vim'
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
alias ports="netstat -a | grep LISTEN"
alias listen="lsof -n -i4TCP:"
alias xcodeaccept="sudo xcodebuild -license accept"
alias bkuphome="cd ~/ && ./.squince_backup_script.sh"
alias icloud="cd ~/Library/Mobile\ Documents/com~apple~CloudDocs"


# git stuffs
alias gitching="git whatchanged | grep -A 4 commit | less"
alias gitbranches="git for-each-ref --format='%(committerdate) %09 %(authorname) %09 %(refname)' | sort -k5n -k2M -k3n -k4n"
alias gitgraph="git log --graph --oneline"
alias gitupstream="git log --oneline --no-merges"
alias gl="git log --graph --date=relative --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset%n%w(0,4,4)%-b%n%n%-N'"

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

# EXPORT PATH VARIABLES
# *********************
export PATH="$PATH:$HOME/.rvm/bin"
export NVM_DIR="/Users/squince/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
export PATH=$PATH:"/usr/local/share/npm/bin"
export PATH="/Users/squince/anaconda3/bin:$PATH"
export PATH="/usr/local/sbin:$PATH" # added by squince 2/12/2018 after upgrading to high sierra

[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" # Load RVM into a shell session *as a function*
