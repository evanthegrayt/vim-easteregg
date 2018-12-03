# vim-easteregg
A very colorful, dark-themed colorscheme for `vim`, inspired by
[Jellybeans.vim](https://github.com/nanotech/jellybeans.vim/blob/master/colors/jellybeans.vim).

## About
A few years ago, I started using the `Jellybeans` colorscheme, but I've modified
it so much over the years, it's become its own entity. I liked the darker theme,
but wanted more colors for different keywords. I kept adding more colors, but
tried to keep a lot of them pastel-ish. The colors and the inspiration from
`Jellybeans` is where I got the name `Easteregg`.

## Screenshot Examples
The font used in the examples is [11pt. Hack](https://sourcefoundry.org/hack/).

```vim
set guifont=Hack:h11
```

![](resource/easteregg.jpg)

## Installation
### Version 8
If you're using `vim` version 8, clone the directory under one of your package
directories.

```bash
git clone https://github.com/evanthegrayt/vim-easteregg.git ~/.vim/pack/[PACKAGE_DIRECTORY]/start/easteregg
```

### Pathogen
If you're not using version 8, I recommend installing
[pathogen](https://github.com/tpope/vim-pathogen), and cloning the repository in
`~/.vim/bundle`. This will allow you to pull updates when they're available.

### No Package Manager
If you're not interested in keeping the plugin up to date, just put the
`easteregg.vim` file in `~/.vim/colors`.

## Configuration
This theme looks best with italics, but this is not enabled by default. To
enable italics, add this line to your `vimrc`, before setting the colorscheme:
```vim
let g:easteregg_use_italics = 1
colorscheme easteregg
```
If your terminal doesn't have italics enabled (which is default for most
terminal emulators), you'll need to [research how to enable them
](https://github.com/evanthegrayt/dotfiles/blob/master/resource/xterm-256color.terminfo#L3).

