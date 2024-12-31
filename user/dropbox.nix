{ pkgs, ... }:

let
  dropboxCmd = "${pkgs.dropbox-cli}/bin/dropbox";

in {
  home.packages = [ pkgs.dropbox-cli ];

  systemd.user.services.dropbox = {
    Unit = { Description = "dropbox"; };

    Install = { WantedBy = [ "default.target" ]; };

    Service = {
      Environment = [ "DISPLAY=" ];

      Type = "forking";
      PIDFile = "%h/.dropbox/dropbox.pid";

      Restart = "on-failure";
      PrivateTmp = true;
      ProtectSystem = "full";
      Nice = 10;

      ExecReload = "${pkgs.coreutils}/bin/kill -HUP $MAINPID";
      ExecStop = "${dropboxCmd} stop";
      ExecStart = "${dropboxCmd} start";
    };
  };
}
