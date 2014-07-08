alias ll='ls -lhaFG'
alias vi='/Applications/MacVim.app/Contents/MacOS/Vim'
alias vim='/Applications/MacVim.app/Contents/MacOS/Vim'
alias td='/usr/local/Cellar/todo-txt/2.9/bin/todo.sh'
alias todo='/usr/local/Cellar/todo-txt/2.9/bin/todo.sh'
alias ll='ls -lha'
alias eclipse='open -a Eclipse'
alias updatestorm='pushd ~/github/Operations/Storm; sudo ./update.sh; popd'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function

export PATH="/usr/local/share/npm/bin:/usr/local/bin:${PATH}"
export EDITOR=vim

# Git completion
if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

set -o vi
source ~/.todo/todo_completion
complete -F _todo td
complete -F _todo todo
