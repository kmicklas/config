{ ... }:

{
  programs.atuin.enable = true;
  programs.atuin.daemon.enable = true;
  programs.atuin.settings = {
    enter_accept = true;
    show_help = false;
    style = "compact";
    inline_height = 0;
    update_check = false;
    daemon.enabled = true;
  };
}
