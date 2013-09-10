export PATH="/usr/local/share/npm/bin:/usr/local/bin:${PATH}"
export EDITOR=vim
export PS1="\$(pwd) \$(promptula) "

alias ll='ls -lha'
alias vi='vim'
alias tm='open -a TextMate'

[[ -s "$HOME/.rvm/scripts/rvm" ]] && . "$HOME/.rvm/scripts/rvm" # Load RVM function
