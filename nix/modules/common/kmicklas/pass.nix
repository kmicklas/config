{ pkgs, ... }:

{
  home.packages = with pkgs; [
    pass
  ];
}
