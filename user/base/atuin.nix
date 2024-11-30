{ config, ... }:

{
  programs.atuin.enable = true;
  programs.atuin.settings = {
    enter_accept = true;
    show_help = false;
    style = "compact";
    update_check = false;
    daemon.enabled = true;
  };

  # TODO: use home-manager service once it exists
  systemd.user.services.atuin = {
    Service.ExecStart = "${config.programs.atuin.package}/bin/atuin daemon";
  };
}
