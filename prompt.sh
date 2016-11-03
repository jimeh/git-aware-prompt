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

set_ps1() {
	if [[ "$git_dirty" != "" && "$git_branch" != "" ]]; then
		ps1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[01;32m\] \$git_branch\[\033[00;31m\]\$git_dirty\[\033[00m\]\[\033[01;34m\] \$\[\033[00m\] " 
	elif [[ "$git_dirty" == "" && "$git_branch" != "" ]]; then 
		ps1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[01;32m\] \$git_branch\[\033[01;34m\] \$\[\033[00m\] "
	else 
		ps1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W \$\[\033[00m\] "
	fi

	export PS1="$ps1"
}

PROMPT_COMMAND="find_git_branch; find_git_dirty; set_ps1; $PROMPT_COMMAND"

# Default Git enabled prompt with dirty state
# export PS1="\u@\h \w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "

# Another variant:
# export PS1="\[$bldgrn\]\u@\h\[$txtrst\] \w \[$bldylw\]\$git_branch\[$txtcyn\]\$git_dirty\[$txtrst\]\$ "

# Default Git enabled root prompt (for use with "sudo -s")
# export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "
