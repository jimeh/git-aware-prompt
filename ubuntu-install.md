# Ubuntu Color Prompt

I present to you a snippet to add to your `~/.bashrc` for Ubuntu users to get your color prompt back. Should work in versions 10.x and up.

Assumptions are that you've cloned git-aware-prompt into your `~/.bash` directory. If you cloned somewhere else, just change the `git_aware_prompt_path` variable in the scriptlet.

## The Code

Add this bit of script to the end of your `~/.bashrc`:

```bash

# Enable Git-aware prompt. Comment out to disable.
git_aware_prompt=yes

# Where you cloned git-aware-prompt, change as needed.
git_aware_prompt_path=~/.bash

# Enable color prompt. Comment out to disable.
color_git_aware_prompt=yes

if [ "$git_aware_prompt" = yes ] ; then
    export GITAWAREPROMPT=${git_aware_prompt_path}/git-aware-prompt

    . ${GITAWAREPROMPT}/main.sh

    if [ "$color_git_aware_prompt" = yes ]; then
        PS1="${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]                                                   \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "
    else
        PS1="${debian_chroot:+($debian_chroot)}\u@\h:\w \[$txtcyn\]\$git_branch\[$txtred\]\$git_dirty\[$txtrst\]\$ "
    fi

#
# Uncomment if you want to know it worked...    
#
#    [ ! -f ~/.hushlogin ] && echo 'Yoohoo! Git-aware prompt was enabled.' && echo
fi

unset color_git_aware_prompt git_aware_prompt git_aware_prompt_path

```

Thanks to jimeh for writing a cool script to start!
