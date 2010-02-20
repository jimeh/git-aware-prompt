function find_git_branch {
   local dir=. head
   until [ "$dir" -ef / ]; do
      if [ -f "$dir/.git/HEAD" ]; then
         head=$(< "$dir/.git/HEAD")
         if [[ $head == ref:\ refs/heads/* ]]; then
            git_branch=" (${head#*/*/})"
         elif [[ $head != '' ]]; then
            git_branch=' (detached)'
         else
            git_branch=' (unknown)'
         fi
         return
      fi
      dir="../$dir"
   done
   git_branch=''
}

PROMPT_COMMAND="find_git_branch; $PROMPT_COMMAND"

# Default Git enabled prompt
# export PS1="\u@\h \w\[$txtcyn\]\$git_branch\[$txtrst\]\\$ "

# Default Git enabled root prompt (for use with "sudo -s")
# export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\[$txtcyn\]\$git_branch\[$txtrst\]\\$ "