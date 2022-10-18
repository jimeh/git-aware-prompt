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

find_git_changed() {
  local branch
  if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null); then
    #local status=$(git status --porcelain 2> /dev/null)  # very slow for large repos!
    #local has_staged_changes=$(git diff-index --quiet --cached HEAD 2> /dev/null)
    #local has_stageable_files=$(git diff-files --quiet  2> /dev/null)
    local status=$(git diff-index --quiet HEAD  2> /dev/null ; echo $?)
    if [[ "$status" == "0" ]]; then
      git_changed=''
    elif [[ "$status" == "1" ]]; then
      git_changed='c'
    elif [[ "$status" == "128" ]]; then
      git_changed=' no_worktree'
    else
      git_changed=" err_$status" # to show if anything else went wrong.
    fi
  else
    git_changed=''
  fi
}

find_git_untracked() {
  git_untracked_num=$( echo $(git ls-files --other --directory --exclude-standard  2> /dev/null | wc -l) )
  if (( "$git_untracked_num" > 0 )); then
    git_untracked='u'
  else
    git_untracked=''
    git_untracked_num=''
  fi
}

find_git_dirty() {
  if [[ "$git_changed" == "" ]] && [[ "$git_untracked" == "" ]]; then
    git_dirty=''
  else
    git_dirty='*'
  fi
}

PROMPT_COMMAND="find_git_branch; find_git_changed; find_git_untracked; find_git_dirty; $PROMPT_COMMAND"

# Default Git enabled prompt with dirty state
# export PS1="\u@\h \w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "

# Another variant:
# export PS1="\[$bldgrn\]\u@\h\[$txtrst\] \w \[$bldylw\]\$git_branch\[$txtcyn\]\$git_dirty\[$txtrst\]\$ "

# A third variant:
# export PS1="${debian_chroot:+($debian_chroot)}\[\033[00;30m\][\D{%F %H:%M}] \[\033[00;32m\]\nyou are here: \w \[$txtcyn\]\$git_branch\[$txtred\]\$git_changed\$git_untracked_bool\$git_dirty\[$txtrst\]\n\[\033[01;32m\]\u\[\033[00;37m\]@\[\033[00;35m\]\h\[\033[00m\]\[\033[00m\]\$ "

# Default Git enabled root prompt (for use with "sudo -s")
# export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "
