# WFMUX: Build an incredible dev workflow with tmux, fzf, entr, and nnn.

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

Wfmux has two configuration file

### Command template for projects (~/.wfmux/cmdset.conf)

```

```

### Automate build and program restart (~/.wfmux/watch.conf)

```

watchers = {
	
}

```

## Screenshots

![](./screenshots/nvim.png)

## Advantages

You would not have to install extra plugins and benefit of the use of the external
programs you've installed and this results in giving less work to (n)vim.

## Disavantages

Opening (n)vim for each buffer on each tmux pane takes much memory than editing
multiple buffers on a single n(vim) instance.

## Authors

- Kueppo (tcheukueppo@gmail.com)
