# Users can set the dirtysymb env var in their .bash_profile, etc,
# or they can leave it unset and it will default to the '*'.
export dirtysymb=${dirtysymb:="*"};

# Show that there is a stash for the current branch
export hasstash=${hasstash:="S"};

find_git_branch() {
  # Based on: http://stackoverflow.com/a/13003854/170413
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    if [[ "$branch" == "HEAD" ]]; then
      branch='detached*'
    fi
    git_branch="($branch)"

  else
    git_branch=""
  fi

}

find_git_stash() {
  local stash
  if [[ -n $(git stash list --grep-reflog="${branch}:" 2> /dev/null ) ]]; then
    git_stash="[$hasstash]"
  else
    git_stash=""
  fi
}

find_git_dirty() {
  local status=$(git status --porcelain 2> /dev/null)
  if [[ "$status" != "" ]]; then
    git_dirty=$dirtysymb
  else
    git_dirty=''
  fi
}

PROMPT_COMMAND="find_git_branch; find_git_dirty; find_git_stash; $PROMPT_COMMAND"

# Default Git enabled prompt with dirty state
# export PS1="\u@\h \w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "

# Default Git enabled prompt with dirty state & showing stashes that for the current branch
# export PS1="\u@\h \w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty$git_stash\[$txtrst\]\$ "

# Another variant:
# export PS1="\[$bldgrn\]\u@\h\[$txtrst\] \w \[$bldylw\]\$git_branch\[$txtcyn\]\$git_dirty\[$txtrst\]\$ "

# Default Git enabled root prompt (for use with "sudo -s")
# export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "
