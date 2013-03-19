find_git_branch() {
   local branch
   # Based on: http://stackoverflow.com/a/13003854/170413
   if branch=$(git rev-parse --abbrev-ref HEAD 2> /dev/null)
   then
   	  if [[ -z "$branch" ]]; then
   	     branch='detached'
   	  fi
   	  git_branch="($branch)"
   else
      git_branch=""
   fi
}

find_git_dirty() {
	if [[ -z "$git_branch" ]]
	then
		git_dirty=''
	else
		# Based on: http://stackoverflow.com/a/2659808/170413
		if git diff-files --quiet
		then
			git_dirty=''
		else
			git_dirty='*'
		fi
	fi
}

PROMPT_COMMAND="find_git_branch; find_git_dirty; $PROMPT_COMMAND"

# Default Git enabled prompt with dirty state
# export PS1="\u@\h \w\[$txtcyn\]\$git_branch\[$txtylw\]\$git_dirty\[$txtrst\]\$ "

# Another variant:
# export PS1="\[$bldgrn\]\u@\h\[$txtrst\] \w\[$bldylw\]\$git_branch\[$txtcyn\]\$git_dirty\[$txtrst\]\$ "

# Default Git enabled root prompt (for use with "sudo -s")
# export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "
