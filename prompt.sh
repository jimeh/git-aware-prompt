find_git_repo() {
  # See also: http://stackoverflow.com/q/15715825/
  local repo
  # Try to get the name of the repository from the remote 'origin'
  if repo=$(git config --local remote.origin.url 2> /dev/null); then
    git_repo="($(basename "$repo" .git))"
  # Fall back to using the name of the Git root directory if there is no remote called origin
  elif repo=$(git rev-parse --show-toplevel 2> /dev/null); then
    git_repo="($(basename "$repo"))"
  else
    git_repo=""
  fi
}

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

PROMPT_COMMAND="find_git_repo; find_git_branch; find_git_dirty; $PROMPT_COMMAND"

# Default Git enabled prompt with dirty state
# export PS1="\u@\h \w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "

# Another variant:
# export PS1="\[$bldgrn\]\u@\h\[$txtrst\] \w \[$bldylw\]\$git_branch\[$txtcyn\]\$git_dirty\[$txtrst\]\$ "

# Another variant showing repository name
# export PS1="\u@\h ]w \[$txtylw\]\$git_repo\[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "

# Default Git enabled root prompt (for use with "sudo -s")
# export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "
