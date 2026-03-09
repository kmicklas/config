{ ... }:

{
  programs.nh.enable = true;
  programs.nh.clean.enable = true;
  programs.nh.clean.extraArgs = "--keep 10 --keep-since 30d";
}
