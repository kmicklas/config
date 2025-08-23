{ pkgs, ... }:

{
  systemd.user.services.rustup-update = {
    Unit = {
      Description = "Update Rust toolchain";
    };

    Service = {
      Type = "oneshot";
      ExecStart = "${pkgs.rustup}/bin/rustup update";
      WorkingDirectory = "%h";
    };
  };

  systemd.user.timers.rustup-update = {
    Unit = {
      Description = "Update Rust toolchain weekly";
      Requires = [ "rustup-update.service" ];
    };

    Timer = {
      OnCalendar = "Sat *-*-* 08:00:00";
      Persistent = true;
    };

    Install = {
      WantedBy = [ "timers.target" ];
    };
  };
}
