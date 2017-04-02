# cd by jumping (cjump)

Boost productivity by quickly and deterministically jumping to predefined paths and their subdirectories (or deeper subdirectories) using aliases.

Inspired by experience working on enormous commercial codebases.

As aliases are predefined, there is no uncertainty as to where an alias will jump to, because `cjump` **doesn't care about usage frequencies** like some tools do. This could be an upside or a downside, depending on your use case or habit.

## Example

You have these long paths that you frequently work with:

- `~/projects/myos/kernel/mem`
- `~/music/classical/orchestra/beethoven/symphonies`
- `~/music/classical/orchestra/dvorak/symphonies`

And **you want to jump to any of them swiftly without hesitation and breaking your flow**.

First, define aliases `myos` and `orch`

    $ cjump alias myos ~/projects/myos
    $ cjump alias orch ~/music/classical/orchestra

Now jump from _anywhere_ to the the directories defined by these aliases:

    $ cj myos
    $ pwd
    ~/projects/myos
    $ cj orch
    $ pwd
    ~/music/classical/orchestra

The `cj myos` makes you jump from anywhere to `~/projects/myos`, while `cj orch` jumps to `~/music/classical/orchestra`.

**That's not it**. Try this:

    $ cj myos mem
    $ pwd
    ~/projects/myos/kernel/mem

Notice that `mem` is a **sub-subdirectory** of `myos`. The `cjump` script is able to search deeper beyond subdirectory level as illustrated below:

     Target:        ~/ projects / myos / kernel / mem
                    ^^^^^^^^^^^^^^^^^^            ^^^
    Command:   cj          myos                   mem

Here `myos` is the predefined alias, but `mem` does _not_ need to be predefined.

Also, when multiple matches are found:

    $ cj orch symphonies
    Multiple matches found:
    
      (1) /home/me/music/classical/orchestra/beethoven/symphonies
      (2) /home/me/music/classical/orchestra/dvorak/symphonies
    
    Which path to jump to?

Simply reply 1 or 2 in this case to pick the path you want to jump to.

## Installation

1. Copy the content of `cjump.sh` to `~/.bashrc` or `~/.zshrc`.
2. Place `cjump` (the Python script) to somewhere in `$PATH`.

## Description

`cjump` itself is a Python script that you can call directly, but it will not perform any jumps. The `cj` function is what you should use to perform the actual jumps. This shell function is needed because there is no way for a child process to modify the working directory of the parent process, and so the Python script cannot change the working directory of the interactive shell you're in.

These are the common operations:

|    Operation                                         |    Command                          |
| ---------------------------------------------------- | ----------------------------------- |
| Jump to an aliased path                              | `cj ALIASNAME`                      |
| Jump to a subdirectory under an aliased path         | `cj ALIASNAME SUBDIR SUBSUBDIR ...` |
| Jump to a subdirectory under the _current_ directory | `cj . SUBDIR SUBSUBDIR...`          |
| Define an alias                                      | `cjump alias ALIASNAME PATH`        |
| Undefine an alias                                    | `cjump unalias ALIASNAME`           |
| Print an alias's path                                | `cjump alias ALIASNAME`             |
| Print all aliases                                    | `cjump alias` or just `cj`          |

Upon running `cjump`, the the alias database `~/.cjump/alias` will be created. This is the only file created by `cjump`.

To change the subdirectory search depth, change the value of `CJUMP_DEPTH`. Its value defaults to 4. Be careful when increasing this value: `cjump` can take a long time to search for subdirectories and return results.

## Requirements

Bash or zsh on macOS or Linux. Python 2 or 3 is required.

## Performance

The act of jumping is very fast. When used on *nix systems, it doesn't spawn any subshell or subprocess unless it's searching for deeper subdirectories.

The search for deeper subdirectories can be slow if you have a huge number of nested files and directories.
