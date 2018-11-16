find_git_branch() {
  # Based on: http://stackoverflow.com/a/13003854/170413
  local branch
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      branch='detached*'
    fi
    git_branch="($branch)"
  else
    git_branch=""
  fi
}

find_git_dirty() {
  local status=$(git status --porcelain 2> /dev/null)
  if [[ "$status" != "" ]]; then
    git_dirty='*'
  else
    git_dirty=''
  fi
}

find_git_delta() {
  if [[ $(git rev-parse --is-inside-work-tree 2> /dev/null) ]]
  then
    local stat
    stat=$(git diff --shortstat)
    git_delta=$(echo $stat | perl -l -ane 'if (/(?:(\d+)? files? changed)?, (?:(\d+?)\sinsertion)?.+?(?:(\d+?)\sdeletion)+?/){ print " $1 Δ +$2:-$3" }')
  else git_delta=''
  fi
}


PROMPT_COMMAND="find_git_branch; find_git_dirty; find_git_delta; $PROMPT_COMMAND"

# Default Git enabled prompt with dirty state
# export PS1="\u@\h \w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "

# Another variant:
# export PS1="\[$bldgrn\]\u@\h\[$txtrst\] \w \[$bldylw\]\$git_branch\[$txtcyn\]\$git_dirty\[$txtrst\]\$ "

# Default Git enabled root prompt (for use with "sudo -s")
# export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "
