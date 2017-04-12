# Manjaro Deep Learning Dotfiles


Most opinionated features of this ML-focused i3 rice:

- Builds MKL-optimized python libs via undocumented hack that doesn't require [`icc`](https://aur.archlinux.org/packages/intel-compiler-base/) !
  - Higher performance than [`anaconda`](https://www.continuum.io/downloads)
  - Less diabolical to setup than [`python-mkl-numpy`](https://aur.archlinux.org/packages/python-numpy-mkl/)
- Privacy-centric `chromium` patchset overlaid via flags + policy files. Provides most of the [`inox patchset`](https://github.com/gcarq/inox-patchset) without the source builds, feature breakage, or version lag.
- Additional Sublime Text + GTK theming for [`wal`](https://github.com/dylanaraps/wal) (colors change based on desktop wallpaper)
- Boarderless YouTube player via `Tampermonkey` userscripts, chromium flags, and custom i3 layout
- Dank `polybar` magic 
- Ricey system-level performance tweaks in `rice.sh` boost wifi performance, compilation speed / performance, and boot speed / silence, 


![scrot](http://i.imgur.com/oFuBqJP.jpg)


## Installation


0. Install [rEFInd as your bootloader](http://www.rodsbooks.com/refind/installing.html) (Recommended) and [rEFInd-minimal theme](https://github.com/EvanPurkhiser/rEFInd-minimal) (Optional)

1. Install fresh copy of [`manjaro-i3`](https://sourceforge.net/projects/manjaro-i3/)
  * Protip: On macs w/ Fusion drives, get higher performance by installing on the SSD. There's a [secret, undocumented way to non-destructively resize a Fusion Drive](http://blog.fosketts.net/2012/10/03/mac-os-corestorage-resize/).

2. `cd ~`

3. `git clone https://github.com/louiehelm/manjaro-ml-dotfiles`

4. `cd manjaro-ml-dotfiles`

5. `./install.sh`

6. Install the [Resize Youtube](https://github.com/Zren/ResizeYoutubePlayerToWindowSize/raw/master/153699.user.js) userscript in `chromium` via `Tampermonkey`

7. Install [Nyan Cat Progress Bar](https://userstyles.org/styles/userjs/95033/YouTube%20-%20Nyan%20Cat%20progress%20bar%20video%20player%20theme.user.js) (Optional Dankness)



## Main Setup

- Application Launcher: `rofi`
- Bar: `polybar`
- Compositor: `compton`
- Cursor: `Capitaine`
- Fonts: `Knack Nerd Font` `Noto Sans`
- Icons: `flattr (modified)`
- IDE: `sublime`
- Notifications: `dunst`
- Shell: `zsh` `oh-my-zsh`
- Terminal Emulator: `termite`
- Text Editor: `vim` `lightline`
- Theme: `Arc (modified)`
- Video Player: `mpv`
- Web Browser: `chromium (hardened)`
- Window Manager: `i3-gaps`


## Optimized Deep Learning Tools

- `Gym`
- `Keras`
- `Numpy` (MKL-optimized)
- `OpenCV` (MKL-optimized)
- `Pillow` (SSE4 + AVX-optimized)
- `Scipy` (MKL-optimized)
- `Tensorflow` (SSE4 + AVX + MKL-optimized)
- `Theano`
- `Universe` 


## Privacy Features

- Chromium: `chromium-flags.conf` `chromium-policies.json` 
- DNS Caching: `unbound`
- Encrypted DNS: `dns-crypt`
- Extensions: `uBlockOrigin` `uBO-Extra`
- Search Engine: [`Googol`](https://github.com/broncowdd/googol)
