# WFMUX: Build an incredible dev workflow with tmux, fzf, entr, and nnn.

(**written in posix sh**)

## Concept



## Why such a setup

Most of the time we are trying to do everything inside (n)vim and this requires a lot
of plugins and somehow (n)vim startup time become huge not to mention how difficult is
to configure all these plugins. We also turn to install plugins which provides 
functionalities which are already present at the command line interface. For instance
look at this.

- Nvimtree (nnn, sfm, ranger)
- Telescope.nvim (fzf, fzy)
- 

and much more.

So why do we want to slow down our incredibly fast (n)vim editor? but well I guess
everyone has his/her own reasons :-).

## Rules

The only fundamental rule is to always use tmux.

## Configuration

A pretty intuitive configuration since we both know the objective

The `program` directive set the default application for open 
if we decide to `use xdg` then the `programs` directive is ignore wfmux
open files with xdg-open.

```

## open files with xdg-open, note that the existence
## of the `program` directive below will overide this
## effect
use xdg;

## set the list of directories which contains your projects
project_directory "~/projects" "~/.local/projects"

## Set default programs for openning your project files
program [
	text:     nvim;
	video:    ffmpeg;
	database: prog_name;
	audio:    aplay;
	image:    feh;
	pdfs:     zathura;
];

## navigate through files with nnn
explorer: nnn;

## fuzzyly select files with fzf
searcher: fzf;

## automate build and server restart with entr
## NB: the automate process is an interactive project
## which is configured interactively.
automater: entr;

## a list of command templates which are usually automated
automation_templates: "~/.wfmux/template";

## set popup window attributes for the file selector
window_attributes_file_selector 20x20+10+20;

## set popup window attributes for every other operation
## that entails the use of a window
window_attributes_rest 20x20+10+20;

```

## Screenshots

![](./screenshots/nvim1.png)
![](./screenshots/nvim2.png)

## Advantages

You would not have to install extra plugins and benefit of the use of the external
programs you've installed and this results in giving less work to (n)vim.

## Disavantages

Opening (n)vim for each buffer on each tmux pane takes much memory than editing
multiple buffers on a single n(vim) instance.

## Authors

- Kueppo (tcheukueppo@gmail.com)
