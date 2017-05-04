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
  local branch
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    #local status=$(git status --porcelain 2> /dev/null)  # very slow for large repos!
    #local has_staged_changes=$(git diff-index --quiet --cached HEAD 2> /dev/null)
    #local has_stageable_files=$(git diff-files --quiet  2> /dev/null)
    local status=$(git diff-index --quiet HEAD  2> /dev/null ; echo $?)
    if [[ "$status" == "0" ]]; then
      git_dirty=''
    elif [[ "$status" == "1" ]]; then
      git_dirty='*'
    elif [[ "$status" == "128" ]]; then
      git_dirty=' no_worktree'
    else
      git_dirty=" err_$status" # to show if anything else went wrong.
    fi
  else
    git_dirty=''
  fi
}

PROMPT_COMMAND="find_git_branch; find_git_dirty; $PROMPT_COMMAND"

# Default Git enabled prompt with dirty state
# export PS1="\u@\h \w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "

# Another variant:
# export PS1="\[$bldgrn\]\u@\h\[$txtrst\] \w \[$bldylw\]\$git_branch\[$txtcyn\]\$git_dirty\[$txtrst\]\$ "

# Default Git enabled root prompt (for use with "sudo -s")
# export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "
