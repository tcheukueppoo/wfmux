# WFMUX

Wfmux lets you enhance your developement workflow through `tmux`. It leverages
tmux's buffers, popup panes, and other tmux features to easily integrate most
command line tools like `fzf`, `entr`, and `nnn` in your workflow. Wfmux also
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

* Configurable
* Project Manager
* Watchers
* File Manager
* Auto-File Opener
* Simple Git Wrapper
* Pop-up shells
* Plugins

### Configuration

Wfmux loads `~/.config/wfmux/wfmux.conf` at startup, in this config file your
default projects' directories is defined as such:

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

### Project Manager

Each opened project has a tmux session. When a project is opened, all the
enabled watchers of that project are started, closing a project shuts down
all its running watchers. Within your terminal emulator you can rapidly
switch between different projects, start a new project, stop some, and so
on.

### Watchers 

Wfmux uses `entr` to watch your files. You can add, delete, modify, enable,
disable, and visualize watchers.

### Git Operations

It's also got few wrappers over some basic git operations like commit,
branch, log, checkout, etc

### File Manager

Open your file manager on a popup tmux pane, do stuffs and then exit.

### File Opener

Automate the opening of project files accross tmux panes.

### Wfmux Plugins

You can add more wfmux operations by writing plugins. Wfmux loads files with
names ending with `.wfmux.sh` at `~/.config/wfmux/plugins`.

Here is a wfmux plugin which displays in tmux the name of the current branch:

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
