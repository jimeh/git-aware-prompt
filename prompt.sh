function settitle () {
  if [ -z "$PC_SET" ]; then
    export PREV_COMMAND=${@}
    export PC_SET=1
  fi
}

trap 'settitle "$BASH_COMMAND"' DEBUG

find_git_branch() {
  # Based on: http://stackoverflow.com/a/13003854/170413
  local branch
  if [[ "$PREV_COMMAND" =~ ^git || "$PREV_COMMAND" =~ ^cd || "$PREV_COMMAND" =~ ^PROMPT_COMMAND ]]; then
    if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
      if [[ "$branch" == "HEAD" ]]; then
        branch='detached*'
      fi
      git_branch="($branch)"
    else
      git_branch=""
    fi
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

PROMPT_COMMAND='find_git_branch; find_git_dirty; '${PROMPT_COMMAND}' export PC_SET="";'

# Default Git enabled prompt with dirty state
# export PS1="\u@\h \w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "

# Another variant:
# export PS1="\[$bldgrn\]\u@\h\[$txtrst\] \w \[$bldylw\]\$git_branch\[$txtcyn\]\$git_dirty\[$txtrst\]\$ "

# Default Git enabled root prompt (for use with "sudo -s")
# export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "
