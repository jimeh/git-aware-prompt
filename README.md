# Git Aware Prompt

Working with Git and its great branching/merging features is
amazing. Constantly switching branches can be confusing though as you have to
run `git status` to see which branch you're currently on.

The solution to this is to have your terminal prompt display the current
branch. There's a [number][1] [of][2] [articles][3] [available][4] online
about how to achieve this.

I based this project mainly on Aaron Crane's [solution][1].

[1]: http://aaroncrane.co.uk/2009/03/git_branch_prompt/
[2]: http://railstips.org/2009/2/2/bedazzle-your-bash-prompt-with-git-info
[3]: http://techblog.floorplanner.com/2008/12/14/working-with-git-branches/
[4]: http://www.intridea.com/2009/2/2/git-status-in-your-prompt


## Overview

If you `cd` to a Git working directory, you will see the current Git branch
name displayed in your terminal prompt. When you're not in a Git working
directory, your prompt works like normal.

![Git Branch in Prompt](https://raw.github.com/jimeh/git-aware-prompt/master/preview.png)


## Installation

Clone the project to a `.bash` folder in your home directory:

```bash
mkdir ~/.bash
cd ~/.bash
git clone git://github.com/jimeh/git-aware-prompt.git
```

Edit your  `~/.profile` or `~/.bash_profile` and add the following to the top:

```bash
export GITAWAREPROMPT=~/.bash/git-aware-prompt
source $GITAWAREPROMPT/main.sh
export PS1="\u@\h \w\[$txtcyn\]\$git_branch\[$txtylw\]\$git_dirty\[$txtgrn\]\$git_ahead_mark\$git_ahead_count\[$txtred\]\$git_behind_mark\$git_behind_count\[$txtrst\] \$ "
```

Optionally, if you want a nice pretty prompt when using `sudo -s`, also add
this line:

```bash
export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "
```

The new prompt will take effect beginning in your next session. This usually
means logging out completely. To enable it in your current session, you can
simply run `source ~/.profile` or `source ~/.bash_profile` (whichever you
edited above) in your terminal.


## Configuring

If you followed the above installation instructions, you've added the default
prompt style already by defining the `PS1` variable. If you don't know how to
customize your prompt, I recommend you check [this][5] how-to.

[5]: http://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html

Basically, to have the current Git branch shown, simply add `$git_branch` to
your `PS1` variable, and make sure the variable value is defined with double
quotes. A set of color variables have also been set for you to use. For a list
of available colors check `colors.sh`.


## Updating

Assuming you followed the default installation instructions and cloned this
repo to `~/.bash/git-aware-prompt`:

```bash
cd ~/.bash/git-aware-prompt
git pull
```


## Usage Tips

To view other user's tips, please check the
[Usage Tips](https://github.com/jimeh/git-aware-prompt/wiki/Usage-Tips) wiki
page. Or if you have tips of your own, feel free to add them :)


## License

```
        DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
                    Version 2, December 2004

 Copyright (C) 2014 Jim Myhrberg

 Everyone is permitted to copy and distribute verbatim or modified
 copies of this license document, and changing it is allowed as long
 as the name is changed.

            DO WHAT THE FUCK YOU WANT TO PUBLIC LICENSE
   TERMS AND CONDITIONS FOR COPYING, DISTRIBUTION AND MODIFICATION

  0. You just DO WHAT THE FUCK YOU WANT TO.
```
