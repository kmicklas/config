{ config, pkgs, ... }:

{
  programs.atuin.enable = true;
  programs.atuin.settings = {
    enter_accept = true;
    show_help = false;
    style = "compact";
    inline_height = 0;
    update_check = false;
    daemon.enabled = true;
  };

  # TODO: use home-manager service once it exists
  systemd.user.services.atuin = {
    Unit = {
      Description = "Atuin shell history daemon";
      Documentation = "https://docs.atuin.sh";
    };
    Service = {
      ExecStartPre="${pkgs.coreutils}/bin/rm -f %h/.local/share/atuin/atuin.sock";
      ExecStart = "${config.programs.atuin.package}/bin/atuin daemon";
    };
    Install.WantedBy = [ "default.target" ];
  };
}
