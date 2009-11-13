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
# PS1="\u@\h:\w\[$txtcyn\]\$git_branch\[$txtrst\]\\$ "