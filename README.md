# WFMUX

![wfmux's logo](url)

Wfmux lets you enhance your developement workflow through `tmux`. It leverages
tmux's buffers, popup panes, and other features to easily integrate most
command line tools like `fzf`, `entr`, and `nnn`. Wfmux also lets you handle
multiple projects with extreme ease. In order to automate your developement
workflow, you just need to configure few tmux bindings specific to wfmux or
simply use the default ones. Wfmux is extensable using shell scripting, you
can write a wfmux plugin that performs a new wfmux operation.

## Features

* Configurable
* Watchers
* Project Manager
* Simple Git Wrapper
* File Manager
* File Opener
* Plugins

### Configuration

Wfmux loads `~/.config/wfmux/wfmux.conf` at startup

To start using wfmux, add this to bottom of your shell's rc file:

```sh
test -z "${TMUX:-}" && command -v wfmux >/dev/null && . wfmux new
```

### Watchers 

### Project Manager

### Git Operations

### File Manager

### File Opener

### Wfmux Plugins
