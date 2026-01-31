{ ... }:

{
  programs.jujutsu.enable = true;
  programs.jujutsu.settings = {
    user.name = "Ken Micklas";

    ui.default-command = "log";
  };

  programs.delta.enableJujutsuIntegration = true;

  programs.jjui.enable = true;
  programs.jjui.settings = {
    preview.show_at_start = true;
  };
}
