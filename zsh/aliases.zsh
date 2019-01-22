alias ll=' exa -lF'
alias la=' exa -GFa'
alias l=' exa -GF'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

alias v='nvim'
alias vs='nvim -O'

alias ipy='ipython3'

alias tml='tmuxp load'

alias pcat="pygmentize -f terminal256 -O style=native -g"

alias gs=' git status'
alias gc=' git commit'
alias gd=' git diff'
alias ga=' git add'
alias gco=' git checkout'
alias gps=' git push'
alias gpsf=' git push --force'
alias gpl=' git pull --rebase'
alias gwc=' git whatchanged'
alias gl=" git log --graph --pretty='%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) %C(bold blue)<%an>%Creset'"
