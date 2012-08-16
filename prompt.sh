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
function find_git_dirty {
    st=$(git status 2>/dev/null | tail -n 1)
    if [[ $st == "" ]]; then
        git_dirty=''
    elif [[ $st == "nothing to commit (working directory clean)" ]]; then
        git_dirty=''
    else
        git_dirty='*'
    fi
}
PROMPT_COMMAND="find_git_branch; find_git_dirty; $PROMPT_COMMAND"

# Default Git enabled prompt with dirty state
# export PS1="\u@\h \w\[$txtcyn\]\$git_branch\[$txtylw\]\$git_dirty\[$txtrst\]\$ "

# Default Git enabled root prompt (for use with "sudo -s")
# export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "