# Running git status can alter permissions/ownership unintentionally, 
# as is also fairly expensive/slow on large repos.
NEED_GIT_STATUS=true

calc_git_staff() {
  local branch
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      branch='detached*'
    fi
    git_branch="($branch)"
    if [[ $NEED_GIT_STATUS ]]; then
      local status=$(git status --porcelain 2> /dev/null)
      if [[ "$status" != "" ]]; then
        git_dirty='*'
      else
        git_dirty=''
      fi
    fi
  else
    git_branch=''
    git_dirty=''
  fi
}

PROMPT_COMMAND="calc_git_staff; $PROMPT_COMMAND"

# Default Git enabled prompt with dirty state
# export PS1="\u@\h \w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "

# Another variant:
# export PS1="\[$bldgrn\]\u@\h\[$txtrst\] \w \[$bldylw\]\$git_branch\[$txtcyn\]\$git_dirty\[$txtrst\]\$ "

# Default Git enabled root prompt (for use with "sudo -s")
# export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "
