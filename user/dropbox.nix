{ pkgs, ... }:

let
  dropboxCmd = "${pkgs.dropbox-cli}/bin/dropbox";

in
{
  home.packages = [ pkgs.dropbox-cli ];

  systemd.user.services.dropbox = {
    Unit = {
      Description = "dropbox";
    };

    Install = {
      WantedBy = [ "default.target" ];
    };

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

  # Restart daily to work around sync randomly stopping
  systemd.user.services.dropbox-restart = {
    Unit = {
      Description = "Restart Dropbox service";
    };

    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.systemd}/bin/systemctl --user restart dropbox.service";
    };
  };

  systemd.user.timers.dropbox-restart = {
    Unit = {
      Description = "Restart Dropbox service daily";
    };

    Timer = {
      OnCalendar = "daily";
      Persistent = true;
    };

    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
