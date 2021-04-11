alias l=' exa -lF --icons'
alias ll=' exa -lF --icons'
alias ls=' exa -lGF --icons'
alias la=' exa -GFa --icons'
alias lla=' exa -lFag --icons'
alias lt=' exa --tree --icons'

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

gprune() {
  if [[ $1 != "--run" ]]; then
    git branch --merged=master | rg -v "master|develop"
  else
    git branch -d $(git branch --merged=master | rg -v "master|develop")
  fi
}

alias onelogin='eval $(op signin aptoma)'

oneitem() {
  op get item $1 | jq '{uuid, title: .overview.title, details, tags: .overview.tags}'
}

onesearch() {
  op list items | jq '.[] | {uuid, title: .overview.title, tags: .overview.tags} | select(.title | contains ("'$1'"))'
}

onetag() {
  op list items | jq '.[] | {uuid, title: .overview.title, tags: .overview.tags} | select(.tags | index("'$1'"))'
}

plog() {
  PROG=$1
  shift
  if [[ $PROG == "brokkr-prod" ]]; then 
    papertrail -g 'Docker Cluster - Production' program:brokkr $@
  elif [[ $PROG == "brokkr-dev" ]]; then
    papertrail -g 'Docker Cluster - Development' program:brokkr $@
  elif [[ $PROG == "docker-prod" ]]; then
    papertrail -g 'Docker Cluster - Production' $@
  else
    echo "Supports 'brokkr-dev', 'brokkr-prod', 'docker-prod'"
  fi
}

mem() {
  ps -eo rss,pid,euser,args:100 --sort %mem | grep -v grep | grep -i $@ | awk '{total += $1; printf $1/1024 "MB"; $1=""; print } END { print "Total: " total/1024 "MB"}'
}

gitdiff() {
    git diff --name-only --diff-filter=d 2>/dev/null | xargs bat --diff
}

dcleanup(){
    docker rm -v $(docker ps --filter status=exited -q 2>/dev/null) 2>/dev/null
    docker rmi $(docker images --filter dangling=true -q 2>/dev/null) 2>/dev/null
}
