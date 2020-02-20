# vim-easteregg
A very colorful, dark-themed colorscheme for `vim`, inspired by
[Jellybeans.vim](https://github.com/nanotech/jellybeans.vim).

## About
A few years ago, I started using the `Jellybeans` colorscheme, but I have
modified it so much over the years, it's become its own entity. I liked the
darker theme, but wanted more colors for different keywords. I kept adding more
colors, but tried to keep a lot of them pastel-ish. The color pallette, plus the
inspiration from `Jellybeans`, is where I got the name `Easteregg`.

## Screenshot Examples
The font used in the examples is [11pt. Hack](https://sourcefoundry.org/hack/).
```vim
set guifont=Hack:h11
```
The languages in the image, from left to right, top to bottom, are `ruby`,
`vimscript`, `bash`, and `c++`

![](https://user-images.githubusercontent.com/12698076/69293829-adc92d80-0bcf-11ea-867d-943080006a44.jpg)

For larger examples, see
[ruby](https://user-images.githubusercontent.com/12698076/74897742-9da32480-535d-11ea-95b2-04af765f3bbd.png),
[vimscript](https://user-images.githubusercontent.com/12698076/74897836-da6f1b80-535d-11ea-9b57-0e02035992fe.png),
[bash](https://user-images.githubusercontent.com/12698076/74898172-b5c77380-535e-11ea-9d46-0baf0f625934.png),
and
[php](https://user-images.githubusercontent.com/12698076/74898334-32f2e880-535f-11ea-8b0b-11557ed63727.png).

## Installation
### Version 8
If you're using `vim` version 8, clone the directory under one of your package
directories.

```bash
git clone https://github.com/evanthegrayt/vim-easteregg.git ~/.vim/pack/$PACKAGE_DIRECTORY/start/easteregg
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
terminal emulators), you'll need to [research how to enable
them](https://github.com/evanthegrayt/dotfiles/blob/master/dotfiles/xterm-256color.terminfo#L3).

## Self Promotion
I do these projects for fun, and I enjoy knowing that they're helpful to people.
Consider starring [the
repository](https://github.com/evanthegrayt/vim-easteregg) if you like it! If
you love it, follow me [on github](https://github.com/evanthegrayt)!
