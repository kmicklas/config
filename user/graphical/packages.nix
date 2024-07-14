pkgs: with pkgs; [
  google-chrome
  evince
  libreoffice
  gimp
  inkscape
  gpxsee
  audacity
  vlc
  spotify
  anki
  transmission-gtk
  xournal
  zoom-us
  signal-desktop
  element-desktop
  calibre
  yt-dlp
  freerdp3

  blueman
  gedit
  gnome3.gnome-control-center
  gnome3.gnome-screenshot
  gnome3.gnome-settings-daemon
  gnome3.nautilus

  dconf # needed for GNOME apps
  dmenu
  acpi
  xscreensaver
  arandr
  alsaUtils
  pavucontrol
  xclip
  feh
  ueberzugpp # TODO: switch to a terminal with native graphics
  libnotify # notify-send

  # Not actually graphical but mainly of use on laptop/desktop:
  lm_sensors
]
