export ZSH=/home/michael/.oh-my-zsh

ZSH_THEME="agnoster"

COMPLETION_WAITING_DOTS="true"

plugins=(bgnotify capistrano vagrant z)

export DISABLE_AUTO_TITLE='true'

export LC_TIME=en_US.UTF-8

export EDITOR='nvim'

setopt RM_STAR_WAIT

export HISTSIZE=32768;
export HISTFILESIZE=$HISTSIZE;
export HISTCONTROL=ignoredups;
export HISTIGNORE="ls:cd:cd -:pwd:exit:date:* --help";

export SSH_KEY_PATH="~/.ssh/rsa_id"

source $ZSH/oh-my-zsh.sh

. ~/.dotfiles/aliases

export NVM_DIR="/home/michael/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm

PATH="$HOME/bin:$PATH"

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$HOME/.local/bin:$PATH"

eval "$(pyenv init -)"

. ~/.dotfiles/zsh-syntax-highlighting

export PATH="$PATH:$HOME/.rvm/bin" # Add RVM to PATH for scripting

[ -s "/home/michael/.scm_breeze/scm_breeze.sh" ] && source "/home/michael/.scm_breeze/scm_breeze.sh"

mem() {
  ps -eo rss,pid,euser,args:100 --sort %mem | grep -v grep | grep -i $@ | awk '{total += $1; printf $1/1024 "MB"; $1=""; print } END { print "Total: " total/1024 "MB"}'
}
