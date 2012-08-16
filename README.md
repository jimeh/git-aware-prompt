# Git Aware Prompt

Working with Git and it's great branching/merging features is amazing. Constantly switching branches can be confusing though as you have to run `git status` to see which branch you're currently on.

The solution to this is to have your terminal prompt display the current branch. There's a [number][1] [of][2] [articles][3] [available][4] online about how to achieve this.

I based this project mainly on Aaron Crane's [solution][1].


## Overview

If you `cd` to a Git working directory, you will see the current Git branch name displayed in your terminal prompt. When you're not in a Git working directory, your prompt works like normal.

![Git Branch in Prompt](http://snap.jimeh.me/git-aware-prompt.png)


## Installation

Clone the project to a `.bash` folder in your home directory:
    
    mkdir ~/.bash
    cd ~/.bash
    git clone git://github.com/mikesten/git-aware-prompt.git

Edit your  `~/.profile` or `~/.bash_profile` and add the following to the top:

    export GITAWAREPROMPT=~/.bash/git-aware-prompt
    source $GITAWAREPROMPT/main.sh
    export PS1="\u@\h \w\[$txtcyn\]\$git_branch\[$txtylw\]\$git_dirty\[$txtrst\]\$ "


Optionally, if you want a nice pretty prompt when using `sudo -s`, also add this line:

    export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "


## Configuring

If you followed the above installation instructions, you've added the default prompt style already by defining the `PS1` variable. If you don't know how to customize your prompt, I recommend you check [this][5] how-to.

Basically, to have the current Git branch shown, simply add `$git_branch` to your `PS1` variable, and make sure the variable value is defined with double quotes. A set of color variables have also been set for you to use. For a list of available colors check `colors.sh`.


## License

(MIT-like license, without the requirement to keep copyright notice in reproductions)

Copyright (c) 2009 Jim Myhrberg

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.



[1]: http://aaroncrane.co.uk/2009/03/git_branch_prompt/
[2]: http://railstips.org/2009/2/2/bedazzle-your-bash-prompt-with-git-info
[3]: http://techblog.floorplanner.com/2008/12/14/working-with-git-branches/
[4]: http://www.intridea.com/2009/2/2/git-status-in-your-prompt
[5]: http://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html