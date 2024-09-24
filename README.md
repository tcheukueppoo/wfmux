# WFMUX

Wfmux lets you enhance your developement workflow through `tmux`. It leverages
tmux's buffers, popup panes, and other tmux features to easily integrate most
command line tools like `fzf`, `entr`, and `nnn` into your workflow. Wfmux also
lets you handle multiple projects with extreme ease. In order to automate your
developement workflow, you just need to configure few tmux bindings specific to
wfmux or simply use the default configuration. Each wfmux tmux binding performs
a specific wfmux operation. Wfmux is extensable via shell scripting, use the
wfmux API to implement new wfmux operations.

## WFMUX OPERATION

A wfmux operation is simply a shell function invoked via tmux. Most wfmux
operation first detect the tmux session from which it was called, check if
that session is a wfmux tmux session before the intended operation is
then performed. A wfmux tmux session is a tmux session dedicated to a
project.

## Features

* [Configurable](https://github.com/tcheukueppoo/wfmux?tab=readme-ov-file#configuration)
* [Project Manager](https://github.com/tcheukueppoo/wfmux?tab=readme-ov-file#project-manager)
* [Watchers](https://github.com/tcheukueppoo/wfmux?tab=readme-ov-file#watchers)
* [Git Wrappers](https://github.com/tcheukueppoo/wfmux?tab=readme-ov-file#git-operations)
* [File Manager](https://github.com/tcheukueppoo/wfmux?tab=readme-ov-file#file-manager)
* [File Opener](https://github.com/tcheukueppoo/wfmux?tab=readme-ov-file#file-opener)
* [Pop-up Terminal](https://github.com/tcheukueppoo/wfmux?tab=readme-ov-file#pop-up-terminal)
* [Plugins](https://github.com/tcheukueppoo/wfmux?tab=readme-ov-file#wfmux-plugins)

### Configuration

Wfmux loads `~/.config/wfmux/wfmux.conf` at startup, in this config file
your default projects' directories is defined as such:

```sh
# Projects are located in $HOME/projects.
# You can add as much directories as you want.
PROJECT_DIRS=$(cat <<END
$HOME/projects
END
)
```

Wfmux lets you select a top-level directory under `$HOME/projects` and
creates a tmux session for it, this session is known as a wfmux tmux
session.

To start using wfmux, add this to the bottom of your shell's rc file:

```sh
test -z "${TMUX:-}" && command -v wfmux >/dev/null && . wfmux new
```

Dump the tmux config related to wfmux and append it to the tmux config.

```sh
wfmux dump && wfmux tmux
```

### Project Manager

Each opened project has a tmux session. When a project is opened, all the
enabled watchers of that project are started, closing a project shuts down
all its running watchers. Within your terminal emulator you can rapidly
switch between different projects, start a new project, stop some, and so
on.

[![asciicast](https://asciinema.org/a/CBsDeno6MWhD79G2Ju0FvElDv.svg)](https://asciinema.org/a/CBsDeno6MWhD79G2Ju0FvElDv)

In the above video, a tmux session is creared for the `amonia` project, a
project file is opened, and the same goes for the `wfmux` project. We then
switch between the different sessions. The tmux session for the `wfmux`
project is killed with that of `amonia`. You have noticed that other
tmux session like `ncmpcpp` for example are not in the list fitted to
`fzf` since it's not a wfmux tmux session.

### Watchers 

Wfmux uses `entr` to watch project files. Through wfmux operations, you
can add, delete, modify, enable, disable, and view the standard output
and error of watchers.

[![asciicast](https://asciinema.org/a/F09lPnAfzk2AKXMH3VY1R9cgk.svg)](https://asciinema.org/a/F09lPnAfzk2AKXMH3VY1R9cgk)

In the above video, we first connect to the tmux session for the `wfmux`
project and view it watchers via the `wtop` wfmux operation. `wtop` says
we got an type `1` enabled (`+`) watcher called `install` that ran `20`
times since this session was created. An enabled watcher is launch at
session startup, a type `1` means the watcher is a one shot watcher;
`0` otherwise. We cycled through stdout and stderr of each watcher
via the configured tmux binding. We then added and started a new watcher
and repeated the previous operations.

### Git Operations

It's also got few wrappers over some basic git operations like git commit,
branch, log, checkout, diff, etc. It has a default plugin which pushes local
changes to remote repositories from github and codeberg.

[![asciicast](https://asciinema.org/a/OzznQQ7yDDJzmf4mr1YOHTWm8.svg)](https://asciinema.org/a/OzznQQ7yDDJzmf4mr1YOHTWm8)

On the maat project, we view its git log, diff and commited changeds made
in `gc.md`.

We still got other wrappers over some git operations interesting to explore.

### File Manager

Open your file manager on a popup tmux pane to do some file operations

[![asciicast](https://asciinema.org/a/oBjktTQ161sffxukpnCYBBDue.svg)](https://asciinema.org/a/oBjktTQ161sffxukpnCYBBDue)

### File Opener

Automate the opening of project files accross tmux panes. You can also use
the `ack` to open project files whose content match a pattern.



### Pop-up Terminal

Just launch a pop-up tmux pane to do stuffs in there and press ctrl-D to
exit.

[![asciicast](https://asciinema.org/a/dNeEeOoTQ0zyRUbr2ujNtltQY.svg)](https://asciinema.org/a/dNeEeOoTQ0zyRUbr2ujNtltQY)

### Wfmux Plugins

We have other wfmux operations you can explore, check them with `wfmux --help`.
You add wfmux operations by writing plugins. Wfmux loads files with names
ending with `.wfmux.sh` at `~/.config/wfmux/plugins`.

Here is an example of wfmux plugin which displays in tmux the name of the
current branch:

```sh
add_plug cbranch

opt_wfmux_cbranch () {
   tmux_or_die

   requires git

   proj_dir=$(get_proj_dir "$(tmux_cur_session)")

   test -z "$proj_dir" && die_not_wfmux

   cd -L "$proj_dir"

   is_git_repository || return

   last_wfmux_opt "$proj_dir" cbranch

   tmux_message "$(git branch --show-current)"
}
```

#### WFMUX API

- `tmux_or_die`: Check if the script is running in a tmux session and die if not.
- `requires`: Check the dependencies of the wfmux operation.
- `get_proj_dir`: Outputs the project directory
- `tmux_cur_session`: Outputs the name of the tmux session of the project.
- `is_git_repository`: Check if the project is tracked by git.
- `tmux_message`: Display a tmux message
- `wfmux_die`: Disply a tmux message and die.
- `last_wfmux_opt`: Tell wfmux the name of the last operation it called.
