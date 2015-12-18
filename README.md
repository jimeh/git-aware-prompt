# Git Aware Prompt

Working with Git and its great branching/merging features is
amazing. Constantly switching branches can be confusing though as you have to
run `git status` to see which branch you're currently on.

The solution to this is to have your terminal prompt display the current
branch. There are a [number][1] [of][2] [articles][3] [available][4] online
about how to achieve this. This project is an attempt to make an easy to
install/configure solution.

[1]: http://aaroncrane.co.uk/2009/03/git_branch_prompt/
[2]: http://railstips.org/2009/2/2/bedazzle-your-bash-prompt-with-git-info
[3]: http://techblog.floorplanner.com/2008/12/14/working-with-git-branches/
[4]: http://www.intridea.com/2009/2/2/git-status-in-your-prompt


## Overview

If you `cd` to a Git working directory, you will see the current Git branch
name displayed in your terminal prompt. When you're not in a Git working
directory, your prompt works like normal.

This fork by joeytwiddle also:
- shows you how far your local branch is **ahead** or **behind** the repository's branch
- shows how many files are **staged**
- indicates when the top **stash** entry was based on the current commit or branch
- adds a **timeout** for slower machines so that you will get your prompt quickly, even if `git status` is taking too long to retrieve the dirty and staged stats. (Tested in bash and zsh.)

If you *only* want the ahead/behind marks (no timeout and no staged stats), you may prefer the branch [ahead_behind](https://github.com/joeytwiddle/git-aware-prompt/tree/ahead_behind) or if you are curious about the code, see [ahead_behind_simple](https://github.com/joeytwiddle/git-aware-prompt/tree/ahead_behind_simple) ([compare](https://github.com/joeytwiddle/git-aware-prompt/compare/jimeh:518685d5d42ab9f298207dd66bbc213775c5cbee...ahead_behind_simple?expand=1)).

![Git Branch in Prompt](https://raw.github.com/joeytwiddle/git-aware-prompt/master/preview.png)

> `<3` indicates that the local branch is 3 commits behind the upstream/remote branch, and could be updated.

> `*2` indicates that the branch is now dirty, with 2 files modified but not committed.

> `>1` indicates that the local branch has 1 commit which has not yet been pushed.

> `+1` would indicate that you have staged 1 file before comitting, but that is not shown above.

> `?4` would indicate that there are 4 untracked files in the tree, also not shown.

> `#` indicates that `git status` was taking too long, so dirty `*` staged `+` and untracked `?` markers will not be shown this time.  `git status` will continue running in the background, so after a few moments, hitting `<Enter>` again should give you an up-to-date summary.

> `(s)` is a reminder that the top stash was made on the current branch, or the current commit.

The symbols (or "markers") can be changed by editing the `prompt.sh` file directly (and reloading it of course).  The numbers or the markers can be omitted by removing the `_count` or `_mark` variables from the `PS1` prompt below.


## See Also

- The [original git-aware-prompt](https://github.com/jimeh/git-aware-prompt) by jimeh

- The [prompt now distributed with git](https://github.com/git/git/blob/master/contrib/completion/git-prompt.sh) offers a `GIT_PS1_SHOWUPSTREAM` option.

- [Oh-my-zsh](https://github.com/robbyrussell/oh-my-zsh) also has its own [git-prompt](https://github.com/robbyrussell/oh-my-zsh/blob/master/plugins/gitfast/git-prompt.sh).  (It has 500 lines compared to our 200.)

- Inspiration for this fork came from [git-branch-status](https://gist.github.com/jehiah/1288596) by jehiah


## Installation

Clone the project to a `.bash` folder in your home directory:

```bash
mkdir ~/.bash
cd ~/.bash
git clone git://github.com/joeytwiddle/git-aware-prompt.git
```

Edit your `~/.bash_profile` or `~/.profile` and add the following to the top:

```bash
export GITAWAREPROMPT=~/.bash/git-aware-prompt
source "${GITAWAREPROMPT}/main.sh"
```


## Configuring

Once installed, there will be new `$git_branch` and `$git_dirty` variables
available to use in the `PS1` environment variable, along with a number of
color helper variables which you can see a list of in [colors.sh][].

[colors.sh]: https://github.com/jimeh/git-aware-prompt/blob/master/colors.sh

If you want to know more about how to customize your prompt, I recommend
this article: [How to: Change / Setup bash custom prompt (PS1)][how-to]

[how-to]: http://www.cyberciti.biz/tips/howto-linux-unix-bash-shell-setup-prompt.html


### Suggested Prompts

Below are a few suggested prompt configurations. Simply paste the code at the
end of the same file you pasted the installation code into earlier.


#### Mac OS X

```bash
export PS1="\u@\h \W \[$txtcyn\]\$git_branch\[$bldgrn\]\$git_ahead_mark\$git_ahead_count\[$txtrst\]\[$bldred\]\$git_behind_mark\$git_behind_count\[$txtrst\]\[$bldyellow\]\$git_stash_mark\[$txtrst\]\[$txtylw\]\$git_dirty\$git_dirty_count\[$txtrst\]\$ "
```

Optionally, if you want a nice pretty prompt when using `sudo -s`, also add
this line:

```bash
export SUDO_PS1="\[$bakred\]\u@\h\[$txtrst\] \w\$ "
```


#### Ubuntu

Standard:

```bash
export PS1="\${debian_chroot:+(\$debian_chroot)}\u@\h:\w \[$txtcyn\]\$git_branch\[$bldgrn\]\$git_ahead_mark\$git_ahead_count\[$txtrst\]\[$bldred\]\$git_behind_mark\$git_behind_count\[$txtrst\]\[$bldyellow\]\$git_stash_mark\[$txtrst\]\[$txtylw\]\$git_dirty\$git_dirty_count\[$txtrst\]\$ "
```

Colorized:

```bash
export PS1="\${debian_chroot:+(\$debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \[$txtcyn\]\$git_branch\[$bldgrn\]\$git_ahead_mark\$git_ahead_count\[$txtrst\]\[$bldred\]\$git_behind_mark\$git_behind_count\[$txtrst\]\[$bldyellow\]\$git_stash_mark\[$txtrst\]\[$txtylw\]\$git_dirty\$git_dirty_count\[$txtrst\]\$ "
```


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

[CC0 1.0 Universal](http://creativecommons.org/publicdomain/zero/1.0/)
