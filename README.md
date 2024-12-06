# dotfiles

My personal dotfiles.

## Requirements

### `i3` - Window Manager

```bash
sudo apt install i3
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

#### Haven't figured it out yet 😞

