# WFMUX: Build an awesome dev workflow with tmux, fzf, entr, and nnn.

(**written in posix sh**)

## Concept

I don't know if that's your case but my development process consist of creating a project
editing some files and if there's something to build, then I build it, if there is a server
to restart then I restart it and at some point I've to push the result to a remote repository,
but well everyone does it.

This project aims to automate this process by not so much depending on (n)vim plugins but
rather use the existing external programs that do the same job the plugins do and we archieve
this with the help of tmux popup windows which run these external programs.

The only fundamental rule is to **always** use tmux.

1. So in short what happens is, when you open your terminal emulator, you are asked to fuzzyly
select a project, then when you select a project a new tmux sessions opens which represents
the project in question.

2. Within this tmux session, you are provided with bindings to perform the following operations on
a tmux popup pane.

- Fuzzyly select a project file to (xdg-)?open.
- Fuzzyly select projects files to bind them an automation task.
- Navigate and manipulate files with your favorite terminal file manager.
- Push (if commited) changes to your remote repositories.
- Add to the index and Commit your changes.

Much is to come based on your needs. I believe the last two task exists because they are
frequently performed.

## Why this kind of setup?

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

## Configuration

A pretty intuitive configuration since we both know the concept.
The `program` directive set the default applications to open files but
if we decide to `use xdg` then the `program` directive is ignored and
wfmux open files with xdg-open.

```

## open files with xdg-open, note that the existence
## of the `program` directive below will overide this
## effect
use xdg;

## set the list of directories which contains your projects
project_directory "~/projects" "~/.local/projects"

## Set default programs for openning your project files
program [
	pdf:      zathura,
	text:     nvim,
	video:    ffmpeg,
	audio:    aplay,
	image:    feh,
	database: prog_name,
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
