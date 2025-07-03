{ ... }:

{
  # Niri enabled in system config for now.
  programs.fuzzel.enable = true;
  programs.swaylock.enable = true;

  xdg.configFile."niri/config.kdl".source = ./config.kdl;
}
