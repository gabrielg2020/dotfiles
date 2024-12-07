# dotfiles

My personal dotfiles.

## Warning

These dotfile are built for MY setup, this mainly goes with my personal prefrences and especially my montior setup.

### Finding Correct Monitor Setup

Currently I have 2 monitors. One 1440p 144hz landscape, another 1080p 100hz veritcal

Find all connected displays

```bash
xrandr
```

Look at the display names. E.g. HDMI-A-0 = 1440p & HDMI-A-1 = 1080p

At the time of writing there is a bug with WayLand, any refresh-rate > 100 will make the screen flash.

### What to change?

Two files will need to be changed `./.config/i3/config` && `./.config/i3/scripts/setup-monitors.sh`

Change any refrence to `HDIM-A-0` or `HDMI-A-1`. You can also change refresh rate, resolution and orientation.

## Requirements

### `i3` - Window Manager

```bash
sudo apt install i3
```

### `picom` - Compositor

```bash
sudo apt install picom
```

### `polybar` - Status Bar

``` bash
sudo apt install polybar
```

### `demenu` - Dynamic Menu

```bash
sudo apt install dmenu
```

### `oh-my-zsh` plugins - Auto Suggestion & Highlighting

```bash
git clone https://github.com/zsh-users/zsh-autosuggestions $ZSH_CUSTOM/plugins/zsh-autosuggestions
git clone https://github.com/zsh-users/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
```

### `xclip` - Shared Clipboard

> [!Warning]
> `xclip` was the clipboard that for my linux distro, you many too change this in `.config/tmux/tmux.conf`
> I think MacOS uses `xsel` and new versions of Ubuntu use `wl-clipboard`

```bash
sudo apt install xclip
```

### Bluetooth tools

```bash
sudo apt install bluetooth bluez bluez-tools pulseaudio-module-bluetooth
```

#### Start, enable and check bluetooth status

```bash
sudo systemctl start bluetooth
```

```bash
sudo systemctl enable bluetooth
```

> [!NOTE]
> Should return something like `... Running ...`

```bash
systemctl status bluetooth
```

### `blueman` - Bluetooth GUI Manager

> [!CAUTION]
> Make sure `pulseaudio-module-bluetooth` is installed...

```bash
sudo apt install blueman
```

### `playerctl` - Media Control

```bash
sudo apt install playerctl
```

## Troubleshooting

### Are applications defualting to light mode?

#### Installing a GTK dark theme

```bash
sudo apt install gnome-theme-extra
```

```bash
vi ~/.config/gtk-3.0/settings.ini
```

Copy and paste this
```bash
[Settings]
gtk-theme-name=Adwaita-dark
gtk-application-prefer-dark-theme=1
```

### Want a background image?

#### Adding a background image

```bash
sudo apt install feh
```

```bash
feh --bg-fill /path/to/image.png
```

### Want to disable mouse acceleration?

#### Removing mouse acceleration

This is a bit of a process.

1. Find your mouse `xinput` id

```bash
xinput list
```

2. List all of your mouse properies and find something with `Accel`

```bash
xinput list-props <id> | grep Accel
```

3. Set that prop to `0, 1`

```bash
# For me the prop was: "libinput Accel Profile Enabled"
xinput set-prop <id> "libinput Accel Profile Enabled" 0, 1
```
