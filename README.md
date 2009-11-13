# Git Branch in Prompt

Working with Git and it's great branching/merging features is amazing. Constantly switching branches can be confusing though as you have to run `git status` to see which branch you're currently on.

The solution to this is to have your terminal prompt display the current branch. There's a [number][1] [of][3] [articles][3] [available][4] online about how to achieve this.

I based this project mainly on [Aaron Crane's solution][1].

[1]: http://aaroncrane.co.uk/2009/03/git_branch_prompt/
[2]: http://railstips.org/2009/2/2/bedazzle-your-bash-prompt-with-git-info
[3]: http://techblog.floorplanner.com/2008/12/14/working-with-git-branches/
[4]: http://www.intridea.com/2009/2/2/git-status-in-your-prompt


## Installation

Clone the project to a `.bash` folder in your home directory:

    git clone git://github.com/jimeh/git-branch-in-prompt.git ~/.bash

Edit your `~/.bash_profile` or `~/.profile` and add the following to the top:

    export DOTBASH=~/.bash
    source $DOTBASH/main.sh
    PS1="\u@\h:\w\[$txtcyn\]\$git_branch\[$txtrst\]\\$ "

Configure your prompt by editing the `PS1 variable`. For a list of available colors check `colors.sh`.


## Screenshot

![Git Branch in Prompt](http://snap.jimeh.me/git-branch-in-prompt.png)


## Issues

Please report any issues and bugs [here][1] on GitHub.

[1]: http://github.com/jimeh/git-branch-in-prompt/issues


## License

(The MIT License)

Copyright (c) 2009 Jim Myhrberg

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.