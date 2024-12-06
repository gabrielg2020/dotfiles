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

```bash
sudo apt install blueman
```

> [!CAUTION]
> Make sure `pulseaudio-module-bluetooth` is installed...

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