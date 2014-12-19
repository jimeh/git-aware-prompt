find_git_branch() {
  # Based on: http://stackoverflow.com/a/13003854/170413
  local branch
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      branch='<detached>'
      # Could show the hash here
      #branch=$(git rev-parse --short HEAD 2>/dev/null)
    fi
    git_branch=" [$branch]"
  else
    git_branch=""
  fi
}

find_git_dirty() {
  # I added the grep -v because I don't mind the odd file hanging around.  Some users may be more strict about this!
  local status_count=$(git status --porcelain 2> /dev/null | grep -v '^??' | wc -l)
  if [[ "$status_count" != 0 ]]; then
    git_dirty='*'
    git_dirty_count="$status_count"
  else
    git_dirty=''
    git_dirty_count=''
  fi
  # TODO: For consistency with ahead/behind variables, git_dirty could be renamed git_dirty_mark
  #       and s/mark/marker/ why not?
}

find_git_ahead_behind() {
  local local_branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
  git_ahead_count=''
  git_ahead_mark=''
  git_behind_count=''
  git_behind_mark=''
  if [[ -n "$local_branch" ]] && [[ "$local_branch" != "HEAD" ]]; then
    local upstream_branch=$(git rev-parse --abbrev-ref "@{upstream}" 2> /dev/null)
    # If we get back what we put in, then that means the upstream branch was not found.  (This was observed on git 1.7.10.4 on Ubuntu)
    [[ "$upstream_branch" = "@{upstream}" ]] && upstream_branch=''
    # If the branch is not tracking a specific remote branch, then assume we are tracking origin/[this_branch_name]
    [[ -z "$upstream_branch" ]] && upstream_branch="origin/$local_branch"
    if [[ -n "$upstream_branch" ]]; then
      git_ahead_count=$(git rev-list --left-right ${local_branch}...${upstream_branch} 2> /dev/null | grep -c '^<')
      git_behind_count=$(git rev-list --left-right ${local_branch}...${upstream_branch} 2> /dev/null | grep -c '^>')
      if [[ "$git_ahead_count" = 0 ]]; then
        git_ahead_count=''
      else
        git_ahead_mark='>'
      fi
      if [[ "$git_behind_count" = 0 ]]; then
        git_behind_count=''
      else
        git_behind_mark='<'
      fi
    fi
  fi
}

PROMPT_COMMAND="find_git_branch; find_git_dirty; find_git_ahead_behind; $PROMPT_COMMAND"

# Default Git enabled prompt with dirty state
# export PS1="\u@\h \w\[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\$git_ahead_mark\$git_behind_mark\[$txtrst\]\$ "

# Another variant, which displays counts after each mark:
# export PS1="\[$bldgrn\]\u@\h\[$txtrst\] \w\[$bldylw\]\$git_branch\[$txtcyn\]\$git_dirty\$git_dirty_count\[$txtgrn\]\$git_ahead_mark\$git_ahead_count\[$txtred\]\$git_behind_mark\$git_behind_count\[$txtrst\]\$ "

# Default Git enabled root prompt (for use with "sudo -s")
# export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "
