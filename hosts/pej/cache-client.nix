{ ... }:

{
  imports = [
    ./mdns.nix
  ];

  nix.settings.substituters = [ "http://pej.local:5000" ];
  nix.settings.trusted-public-keys =
    [ "pej-1:iQeDet8R/CBb3q5QbAEulByw4Hopk/jN5MhYvNzchh0=" ];
}
