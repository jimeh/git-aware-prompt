is_this_a_git_repo() {
  is_in_git=$(git rev-parse --is-inside-work-tree 2> /dev/null)
}

find_git_branch() {
  # Based on: http://stackoverflow.com/a/13003854/170413
  local branch
  echo $is_in_git
  if [[ "$is_in_git" = "true" ]]; then
    if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
      if [[ "$branch" == "HEAD" ]]; then
        branch='detached*'
      fi
      git_branch="($branch)"
    fi
  else
    git_branch=""
  fi
}

find_git_dirty() {
  if [[ "$is_in_git" = "true" ]]; then
    local status=$(git status --porcelain 2> /dev/null)
    if [[ "$status" != "" ]]; then
      git_dirty='*'
    fi
  else
    git_dirty=''
  fi
}

find_head_tag() {
  if [[ "$is_in_git" = "true" ]]; then
    local tag=$(git tag --column --points-at HEAD 2> /dev/null)
    if [[ ! -z $tag ]]; then
      git_head_tag="HEAD:$tag"
    else
      git_head_tag='HEAD:not tagged'
    fi
  else
    git_head_tag=''
  fi 
}

PROMPT_COMMAND="is_this_a_git_repo; find_git_branch; find_git_dirty; find_head_tag;$PROMPT_COMMAND"

# Default Git enabled prompt with dirty state
# export PS1="\u@\h \w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "

# Another variant:
# export PS1="\[$bldgrn\]\u@\h\[$txtrst\] \w \[$bldylw\]\$git_branch\[$txtcyn\]\$git_dirty\[$txtrst\]\$ "

# Default Git enabled root prompt (for use with "sudo -s")
# export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "
