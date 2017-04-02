# cd by jumping (cjump)

Boost productivity by quickly and _deterministically_ jumping to predefined paths and their subdirectories (or deeper subdirectories) using aliases.

Inspired by experience working on enormous commercial codebases.

As aliases are predefined, there is no uncertainty as to where an alias will jump to, because cjump doesn't care about usage frequencies like some tools do. This could be an upside or a downside, depending on your use case or habit.

## How does it work?

You have these long paths:

- `~/projects/myos/kernel/mem`
- `~/music/classical/orchestra/beethoven/symphonies`
- `~/music/classical/orchestra/dvorak/symphonies`

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
                                  ^^^^            ^^^
    Command:   cj                 myos            mem

Here `myos` is the predefined alias, but `mem` does _not_ need to be predefined.

Also, when multiple matches are found:

    $ cj orch symphonies
    Multiple matches found:
    
      (0) /home/me/music/classical/orchestra/beethoven/symphonies
      (1) /home/me/music/classical/orchestra/dvorak/symphonies
    
    Which one to jump to?

Simply reply 0 or 1 in this case to pick the path you want to jump to.

## Installation

1. Copy the content of `cjump.sh` to `~/.bashrc`.
2. Place `cjump` (the Python script) to somewhere in `$PATH`.

## Files

Upon running `cjump`, the the alias database `~/.cjump/alias` will be created. This is the only file created by `cjump`.

## Requirements

Bash on macOS or Linux. Python 2 or 3 is required.

## Limitations

Paths containing newlines are not supported. But nobody uses those anyway, right?

## Performance

The act of jumping is very fast. When used on *nix systems, it doesn't spawn any subshell or subprocess unless it's searching for deeper subdirectories.

The search for deeper subdirectories can be slow if you have a huge number of nested files and directories.
